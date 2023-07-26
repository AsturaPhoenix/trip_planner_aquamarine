import 'dart:async';

import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  const BlinkingIcon({
    super.key,
    required this.icons,
    this.interval = const Duration(milliseconds: 750),
  });
  final List<IconData> icons;
  final Duration interval;
  @override
  State<StatefulWidget> createState() => BlinkingIconState();
}

class BlinkingIconState extends State<BlinkingIcon> {
  late Timer timer;

  Timer createTimer() =>
      Timer.periodic(widget.interval, (_) => setState(() {}));

  @override
  void initState() {
    super.initState();
    timer = createTimer();
  }

  @override
  void didUpdateWidget(covariant BlinkingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.interval != oldWidget.interval) {
      timer.cancel();
      timer = createTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) =>
      Icon(widget.icons[timer.tick % widget.icons.length]);
}
