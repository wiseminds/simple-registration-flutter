import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  @override
  final RouteSettings settings;

  final Duration? duration;
  FadeRoute({this.duration, required this.settings, required this.page})
      : super(
            settings: settings,
            transitionDuration: duration ?? const Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                  opacity: animation,
                  child: FadeTransition(
                      opacity: ReverseAnimation(secondaryAnimation),
                      // animation: animation,
                      // secondaryAnimation: secondaryAnimation,
                      child: child));
            });
}
