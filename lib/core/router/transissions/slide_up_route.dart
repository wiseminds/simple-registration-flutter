import 'package:flutter/material.dart';

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  @override
  final RouteSettings settings;
  SlideUpRoute({required this.settings, required this.page})
      : super(
            settings: settings,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                    position: Tween<Offset>(
                      // begin: Offset(isRight ? -1 : 1, 0),
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                        // animation
                        CurvedAnimation(
                            parent: animation,
                            curve: Curves.linear,
                            reverseCurve: Curves.linear)),
                    child: child));
}
