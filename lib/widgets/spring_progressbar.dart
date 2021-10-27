import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';
import 'package:challenge/core/extensions/index.dart';

class SpringProgressbar extends StatefulWidget {
  final double progress;

  const SpringProgressbar({Key? key, this.progress = .8}) : super(key: key);
  @override
  __ProgressState createState() => __ProgressState();
}

class __ProgressState extends State<SpringProgressbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        value: 0.0,
        duration: Duration(milliseconds: 1000));
    super.initState();
    if (mounted)
      Future.delayed(
          Duration(milliseconds: 900),
          () => _controller.animateTo(min(1, max(widget.progress, 0)),
              duration: Duration(milliseconds: 2000),
              curve: Sprung.criticallyDamped));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.5,
      child: AnimatedBuilder(
        animation: _controller.view,
        builder: (c, child) {
          return LinearProgressIndicator(
            value: _controller.value,
            valueColor: AlwaysStoppedAnimation(context.primaryColor),
            backgroundColor: context.primaryColor.withOpacity(.1),
          );
        },
      ),
    );
  }
}
