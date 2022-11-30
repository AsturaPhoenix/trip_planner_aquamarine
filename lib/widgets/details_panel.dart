import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/trip_planner_client.dart';
import '../util/optional.dart';

class DetailsPanel extends StatelessWidget {
  const DetailsPanel({super.key, required this.client, this.station});
  final TripPlannerClient client;
  final Station? station;

  @override
  Widget build(BuildContext context) {
    final hasScrollbar = const {
      TargetPlatform.linux,
      TargetPlatform.macOS,
      TargetPlatform.windows
    }.contains(defaultTargetPlatform);

    return station?.details == null
        ? Container()
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 4, hasScrollbar ? 8 : 4, 4),
              child: LayoutBuilder(
                builder: (context, boxConstraints) => Html(
                  data: station!.details,
                  style: {
                    'body': Style(fontSize: FontSize(16)),
                    '[style*="visibility:hidden"]':
                        Style(color: Colors.transparent),
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
                  onLinkTap: (url, _, __, ___) =>
                      Optional(url).map((url) => launchUrl(Uri.parse(url))),
                ),
              ),
            ),
          );
  }
}
