import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/trip_planner_client.dart';
import '../util/optional.dart';
import '../util/subordinate_scroll_controller.dart';

class DetailsPanel extends StatefulWidget implements ScrollControllerProvider {
  const DetailsPanel({
    super.key,
    required this.client,
    required this.station,
    this.scrollController,
  });
  final TripPlannerClient client;
  final Station station;
  @override
  final ScrollController? scrollController;

  @override
  State<DetailsPanel> createState() => DetailsPanelState();
}

class DetailsPanelState extends State<DetailsPanel>
    with AutomaticKeepAliveClientMixin, SubordinateScrollControllerStateMixin {
  void onLinkTap(String? url, _, __, ____) =>
      // TODO: error indicator and/or change rendering if we can't launch
      Optional(url).map((url) => launchUrl(Uri.parse(url)));

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final hasScrollbar = const {
      TargetPlatform.linux,
      TargetPlatform.macOS,
      TargetPlatform.windows
    }.contains(defaultTargetPlatform);

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.only(right: hasScrollbar ? 8.0 : 0.0),
        child: (widget.station.type.isTideCurrent
            ? TideCurrentDetails.new
            : PoiDetails.new)(
          client: widget.client,
          station: widget.station,
          onLinkTap: onLinkTap,
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
                final height = Optional(context.tree.attributes['height'])
                    .map(double.parse);

                final image = SizedBox(
                  width: width,
                  height: height,
                  child: UnconstrainedBox(
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      image: client.getImage(
                        Uri.parse(context.tree.attributes['src']!),
                      ),
                      width: width,
                      height: width == null ? height : null,
                      gaplessPlayback: true,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : CircularProgressIndicator(
                                  value: Optional(
                                    loadingProgress.expectedTotalBytes,
                                  ).map(
                                    (total) =>
                                        loadingProgress.cumulativeBytesLoaded /
                                        total,
                                  ),
                                ),
                    ),
                  ),
                );

                return detailsImg
                    ? Center(
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
                  'body': Style(textAlign: TextAlign.center),
                  'table': Style(
                    backgroundColor: const Color(0xffcbdcff),
                    fontSize: FontSize(.8, Unit.em),
                    textAlign: TextAlign.left,
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
                : const Center(child: CircularProgressIndicator()),
      );
}
