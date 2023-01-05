import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import 'package:joda/time.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TimePoint {
  TimePoint({required this.time, required this.index});
  final Instant time;
  final int index;
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
    this.tracks = const [],
    required this.onTracksChanged,
  });
  final Instant? t;
  final TimeZone timeZone;
  final List<Track> tracks;
  final void Function(List<Track>) onTracksChanged;

  late final selectedCount = tracks.where((track) => track.selected).length;

  @override
  State<StatefulWidget> createState() => PlotPanelState();
}

class PlotPanelState extends State<PlotPanel>
    with AutomaticKeepAliveClientMixin<PlotPanel> {
  final scrollController = ScrollController();
  int? selectionStart;

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
      }
    }

    widget.onTracksChanged(tracks);
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Overlay GPS tracking to see your tracks on nautical charts.',
            ),
            if (tracks.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Flexible(
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
                                  onPressed: () {
                                    // TODO: color picker
                                  },
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
            )
          ],
        ),
      ),
    );
  }
}
