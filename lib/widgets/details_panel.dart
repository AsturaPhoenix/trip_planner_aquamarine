import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../providers/trip_planner_client.dart';
import '../util/optional.dart';

class DetailsPanel extends StatelessWidget {
  const DetailsPanel({super.key, required this.client, this.station});
  final TripPlannerClient client;
  final Station? station;

  @override
  Widget build(BuildContext context) => station?.details == null
      ? Container()
      : SingleChildScrollView(
          child: Html(
            data: station!.details,
            style: {
              '[style*="visibility:hidden"]': Style(color: Colors.transparent)
            },
            customRenders: {
              tagMatcher('img'): CustomRender.widget(
                widget: (context, childBuilder) {
                  // Prefer setting width rather than height to keep display
                  // more consistent. Flutter will instead prefer height by
                  // default. On web, this actually warps the aspect ratio for
                  // some images, which we probably shouldn't replicate.
                  final width = Optional(context.tree.attributes['width'])
                      .map(double.parse);
                  final height = width != null
                      ? null
                      : Optional(context.tree.attributes['height'])
                          .map(double.parse);

                  return Image(
                    image: client
                        .getImage(Uri.parse(context.tree.attributes['src']!)),
                    width: width,
                    height: height,
                  );
                },
              )
            },
          ),
        );
}
