import 'dart:convert';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import 'package:joda/time.dart' hide DateTime;
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../util/distance.dart';
import 'color_picker.dart';
import 'iterative_column.dart';

const _uuid = Uuid();

class TimePoint {
  TimePoint({required this.time, required this.index});
  final Instant time;
  final int index;
}

class TimeSeries<T> {
  TimeSeries({required this.time, required this.value});
  final Instant time;
  final T value;
}

class Segment {
  Segment({required this.key, List<Wpt> trkpts = const []})
      : points = [for (final wpt in trkpts) LatLng(wpt.lat!, wpt.lon!)],
        times = [
          for (int i = 0; i < trkpts.length; ++i)
            if (trkpts[i].time != null)
              TimePoint(index: i, time: Instant(trkpts[i].time!))
        ];

  final PolylineId key;
  final List<LatLng> points;
  final List<TimePoint> times;

  List<TimeSeries<Speed>> deriveSpeeds([
    Duration minPeriod = const Duration(seconds: 30),
  ]) {
    final speeds = <TimeSeries<Speed>>[];

    if (times.length >= 2) {
      var t0 = times.first;

      void addSpeed(int end, Duration dt) {
        var dx = 0.0;
        for (int i = t0.index; i < end; ++i) {
          dx += Geolocator.distanceBetween(
            points[i].latitude,
            points[i].longitude,
            points[i + 1].latitude,
            points[i + 1].longitude,
          );
        }

        speeds.add(
          TimeSeries(time: t0.time + dt ~/ 2, value: Speed(Meters(dx), dt)),
        );
      }

      for (final t in times.skip(1).take(times.length - 2)) {
        final dt = t.time.difference(t0.time);
        if (dt < minPeriod) continue;

        addSpeed(t.index, dt);
        t0 = t;
      }

      addSpeed(times.last.index, times.last.time.difference(t0.time));
    }

    return speeds;
  }
}

class Track {
  Track({
    required this.key,
    required this.name,
    this.color = Colors.red,
    this.segments = const [],
    this.selected = false,
  });
  final String key;
  final String name;
  final Color color;
  final List<Segment> segments;
  final bool selected;

  Track copyWith({
    String? key,
    String? name,
    Color? color,
    List<Segment>? segments,
    bool? selected,
  }) =>
      Track(
        key: key ?? this.key,
        name: name ?? this.name,
        color: color ?? this.color,
        segments: segments ?? this.segments,
        selected: selected ?? this.selected,
      );
}

class PlotPanel extends StatefulWidget {
  PlotPanel({
    super.key,
    this.t,
    required this.timeZone,
    required this.distanceSystem,
    this.tracks = const [],
    required this.onTracksChanged,
    this.onModal,
  });
  final Instant? t;
  final TimeZone timeZone;
  final ValueNotifier<DistanceSystem> distanceSystem;
  final List<Track> tracks;
  final void Function(List<Track>) onTracksChanged;
  final void Function(bool modal)? onModal;

  late final selectedCount = tracks.where((track) => track.selected).length;

  @override
  State<StatefulWidget> createState() => PlotPanelState();
}

class PlotPanelState extends State<PlotPanel>
    with AutomaticKeepAliveClientMixin<PlotPanel> {
  final scrollController = ScrollController();
  int? selectionStart;
  var _speeds = <Segment, List<TimeSeries<Speed>>>{};
  Speed? _maxSpeed;

  @override
  bool get wantKeepAlive => true;

  List<Track> get tracks => widget.tracks;

  void _onTrackTap(int index, Track current) {
    final keys = LogicalKeyboardKey.collapseSynonyms(
      HardwareKeyboard.instance.logicalKeysPressed,
    );

    if (keys.contains(LogicalKeyboardKey.control)) {
      _toggleTrack(index, current);
    } else if (keys.contains(LogicalKeyboardKey.shift) &&
        selectionStart != null) {
      if (index == selectionStart && widget.selectedCount == 1) {
        selectionStart = null;
        widget.onTracksChanged([
          for (final track in tracks) track.copyWith(selected: false),
        ]);
      } else {
        int lb, ub;
        if (selectionStart! <= index) {
          lb = selectionStart!;
          ub = index;
        } else {
          lb = index;
          ub = selectionStart!;
        }
        widget.onTracksChanged([
          for (int i = 0; i < lb; ++i) tracks[i].copyWith(selected: false),
          for (int i = lb; i <= ub; ++i) tracks[i].copyWith(selected: true),
          for (int i = ub + 1; i < tracks.length; ++i)
            tracks[i].copyWith(selected: false)
        ]);
      }
    } else {
      final select = !current.selected || widget.selectedCount > 1;
      selectionStart = select ? index : null;
      widget.onTracksChanged([
        for (final track in tracks)
          track.copyWith(selected: track == current && select)
      ]);
    }
  }

  void _toggleTrack(int index, Track current) {
    selectionStart = current.selected ? null : index;
    widget.onTracksChanged([
      for (final track in tracks)
        track == current ? track.copyWith(selected: !track.selected) : track
    ]);
  }

  void _selectColor(BuildContext context, Track current) async {
    widget.onModal?.call(true);
    final color =
        await showColorPicker(context: context, initialColor: current.color);
    widget.onModal?.call(false);
    if (color == null) return;

    widget.onTracksChanged([
      for (final track in tracks)
        track == current ? track.copyWith(color: color) : track
    ]);
  }

  void _removeTrack(Track current) {
    widget.onTracksChanged([
      for (final track in tracks)
        if (track != current) track
    ]);
  }

  void addGpx() async {
    // TODO: iOS?
    final supportsCustomFilter =
        defaultTargetPlatform != TargetPlatform.android;
    final files = await FilePicker.platform.pickFiles(
      type: supportsCustomFilter ? FileType.custom : FileType.any,
      allowedExtensions: supportsCustomFilter ? ['gpx'] : null,
      withData: true,
      allowMultiple: true,
    );
    if (files == null) return;

    final tracks = [
      for (final track in this.tracks) track.copyWith(selected: false)
    ];
    bool tracksAdded = false;

    for (final file in files.files) {
      // TODO: use encoding from ?xml tag
      final gpx = GpxReader().fromString(utf8.decoder.convert(file.bytes!));

      for (final trk in gpx.trks) {
        tracks.add(
          Track(
            key: _uuid.v4(),
            name: trk.name ?? basenameWithoutExtension(file.name),
            segments: [
              for (final trkseg in trk.trksegs)
                Segment(key: PolylineId(_uuid.v4()), trkpts: trkseg.trkpts)
            ],
            selected: true,
          ),
        );
        tracksAdded = true;
      }
    }

    widget.onTracksChanged(tracks);
    // (Go ahead and deselect all even if no tracks were added.)

    if (tracksAdded) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      );
    }
  }

  void _updateSpeeds() {
    _speeds = {
      for (final track in tracks)
        if (track.selected)
          for (final segment in track.segments)
            segment: _speeds[segment] ?? segment.deriveSpeeds()
    };

    _maxSpeed = null;
    for (final series in _speeds.values) {
      for (final sample in series) {
        if (_maxSpeed == null || _maxSpeed! < sample.value) {
          _maxSpeed = sample.value;
        }
      }
    }
  }

  void _setDistanceSystem(DistanceSystem? distanceSystem) =>
      widget.distanceSystem.value = distanceSystem!;

  @override
  void initState() {
    super.initState();
    _updateSpeeds();
  }

  @override
  void didUpdateWidget(PlotPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tracks != oldWidget.tracks) {
      _updateSpeeds();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Both the padding and button size expand on mobile, so maintaining
          // consistent spacing gets complicated if we allow for tap target
          // expansion here. It may be worth finding a solution with more
          // finesse.
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: IterativeColumn(
          children: [
            const Text(
              'Overlay GPS tracking to see your tracks on nautical charts.',
            ),
            if (tracks.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              IterativeFlexible(
                pass: 1,
                size: (availableSize) => _maxSpeed != null
                    ? min(max(availableSize - 128, 56), availableSize)
                    : availableSize,
                child: Material(
                  color: theme.colorScheme.secondaryContainer,
                  elevation: 1.0,
                  // TODO: ReorderableListView.builder
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < tracks.length; ++i)
                          ListTile(
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(tracks[i].name),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size.square(16.0),
                                    minimumSize: Size.zero,
                                    backgroundColor: tracks[i].color,
                                  ),
                                  child: null,
                                  onPressed: () =>
                                      _selectColor(context, tracks[i]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => _removeTrack(tracks[i]),
                                ),
                              ],
                            ),
                            horizontalTitleGap: 0,
                            contentPadding: EdgeInsets.zero,
                            selectedTileColor: const Color(0x20405080),
                            selected: tracks[i].selected,
                            onTap: () => _onTrackTap(i, tracks[i]),
                            onLongPress: () => _toggleTrack(i, tracks[i]),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: addGpx,
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Overlay GPX'),
            ),
            ...(_maxSpeed == null)
                ? [const SizedBox(height: 8.0)]
                : [
                    IterativeFlexible(
                      pass: 2,
                      size: (availableSize) => min(128, availableSize),
                      child: ValueListenableBuilder(
                        valueListenable: widget.distanceSystem,
                        builder: (context, distanceSystem, _) =>
                            charts.TimeSeriesChart(
                          [
                            for (final track in tracks)
                              if (track.selected)
                                for (final segment in track.segments)
                                  charts.Series<TimeSeries<Speed>, DateTime>(
                                    id: segment.key.value,
                                    seriesColor: charts.ColorUtil.fromDartColor(
                                        track.color),
                                    data: segment.deriveSpeeds(),
                                    domainFn: (datum, _) => datum.time.value,
                                    measureFn: (datum, _) =>
                                        datum.value.forSystem(distanceSystem),
                                  )
                          ],
                          animate: false,
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            viewport: charts.NumericExtents(
                              0,
                              _maxSpeed!.forSystem(distanceSystem),
                            ),
                            renderSpec: const charts.GridlineRendererSpec(
                              minimumPaddingBetweenLabelsPx: 8,
                            ),
                            tickProviderSpec:
                                const charts.BasicNumericTickProviderSpec(
                              zeroBound: true,
                              desiredMinTickCount: 5,
                              desiredMaxTickCount: 10,
                            ),
                          ),
                          domainAxis: const charts.DateTimeAxisSpec(
                            renderSpec: charts.GridlineRendererSpec(
                              minimumPaddingBetweenLabelsPx: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: widget.distanceSystem,
                      builder: (context, distanceSystem, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final value in DistanceSystem.values) ...[
                            if (value.index > 0) const SizedBox(width: 8.0),
                            Radio(
                              value: value,
                              groupValue: distanceSystem,
                              onChanged: _setDistanceSystem,
                            ),
                            Text(Speed.systemDescription(value))
                          ]
                        ],
                      ),
                    ),
                  ],
          ],
        ),
      ),
    );
  }
}
