import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/trip_planner_client.dart';
import '../util/optional.dart';

class DetailsPanel extends StatelessWidget {
  const DetailsPanel({
    super.key,
    required this.client,
    required this.station,
    this.preferredHeight = 256,
  });
  final TripPlannerClient client;
  final Station station;
  final double preferredHeight;

  void onLinkTap(String? url, _, __, ____) =>
      // TODO: error indicator and/or change rendering if we can't launch
      Optional(url).map((url) => launchUrl(Uri.parse(url)));

  @override
  Widget build(BuildContext context) {
    final hasScrollbar = const {
      TargetPlatform.linux,
      TargetPlatform.macOS,
      TargetPlatform.windows
    }.contains(defaultTargetPlatform);

    return LayoutBuilder(
      builder: (context, boxConstraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: min(boxConstraints.minHeight, preferredHeight),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 4, hasScrollbar ? 8 : 4, 4),
            child: (station.type.isTideCurrent
                ? TideCurrentDetails.new
                : PoiDetails.new)(
              client: client,
              station: station,
              onLinkTap: onLinkTap,
            ),
          ),
        ),
      ),
    );
  }
}

class PoiDetails extends StatelessWidget {
  const PoiDetails({
    super.key,
    required this.client,
    required this.station,
    this.onLinkTap,
  });
  final TripPlannerClient client;
  final Station station;
  final OnTap? onLinkTap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, boxConstraints) => Html(
          data: station.details ?? 'No data',
          style: {
            'body': Style(fontSize: FontSize(16)),
            '[style*="visibility:hidden"]': Style(color: Colors.transparent),
            '.details_caption': Style(
              // flutter_html#1146: Ideally this would be block, but that
              // sometimes introduces spurious newlines. Unit.percent
              // doesn't seem to work either.
              display: Display.inlineBlock,
              width: Width(boxConstraints.maxWidth),
              fontSize: FontSize(.9, Unit.em),
              fontStyle: FontStyle.italic,
              textAlign: TextAlign.center,
            ),
          },
          customRenders: {
            tagMatcher('img'): CustomRender.widget(
              widget: (context, childBuilder) {
                final detailsImg =
                    context.tree.elementClasses.contains('details_img');

                // Prefer setting width rather than height to keep display
                // more consistent. Flutter will instead prefer height by
                // default. On web, this actually warps the aspect ratio
                // for some images, which we probably shouldn't replicate.
                //
                // Ideally we'd fill the width, but these images tend to
                // actually only be about 400px wide.
                final width = Optional(context.tree.attributes['width'])
                    .map(double.parse);
                final height = width != null
                    ? null
                    : Optional(context.tree.attributes['height'])
                        .map(double.parse);

                final image = Image(
                  image: client.getImage(
                    Uri.parse(context.tree.attributes['src']!),
                  ),
                  width: width,
                  height: height,
                );

                return detailsImg
                    ? Align(
                        alignment: Alignment.center,
                        heightFactor: 1,
                        child: image,
                      )
                    : image;
              },
            )
          },
          onLinkTap: onLinkTap,
        ),
      );
}

class TideCurrentDetails extends StatefulWidget {
  const TideCurrentDetails({
    super.key,
    required this.client,
    required this.station,
    this.onLinkTap,
  });
  final TripPlannerClient client;
  final Station station;
  final OnTap? onLinkTap;

  @override
  TideCurrentDetailsState createState() => TideCurrentDetailsState();
}

class TideCurrentDetailsState extends State<TideCurrentDetails> {
  Future<String>? details;

  @override
  void initState() {
    super.initState();
    details = widget.client.getTideCurrentStationDetails(widget.station);
  }

  @override
  void didUpdateWidget(covariant TideCurrentDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.client != oldWidget.client ||
        widget.station != oldWidget.station) {
      details = widget.client.getTideCurrentStationDetails(widget.station);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: details,
        builder: (context, snapshot) => snapshot.hasData
            ? Html(
                data: snapshot.data,
                style: {
                  'table': Style(
                    backgroundColor: const Color(0xffcbdcff),
                    fontSize: FontSize(.8, Unit.em),
                  ),
                  'td': Style(
                    border: Border.all(width: 0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                  ),
                  '.about_line1': Style(fontWeight: FontWeight.bold),
                  '.about_col1': Style(
                    alignment: Alignment.topCenter,
                    fontWeight: FontWeight.bold,
                  ),
                  'font[face="monospace"]': Style(fontFamily: 'RobotoMono'),
                },
                customRenders: {tableMatcher(): tableRender()},
                onLinkTap: widget.onLinkTap,
              )
            : snapshot.hasError
                ? Text(snapshot.error?.toString() ?? 'Error')
                : const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
      );
}
