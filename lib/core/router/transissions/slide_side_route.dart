import 'package:flutter/material.dart';

class SlideSideRoute extends PageRouteBuilder {
  final Widget page;
  final bool isRight;
  @override
  final RouteSettings settings;
  final Duration? duration;

  SlideSideRoute(
      {this.duration,required this.settings, required this.page, this.isRight = false})
      : super(
          settings: settings,
          reverseTransitionDuration: Duration(milliseconds: 400),
          transitionDuration: duration ?? Duration(milliseconds: 400),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            //       print(animation.value);
            // print('animation is dismissed ${animation.isDismissed}');
            // print(
            //     'secondaryAnimation is dismissed ${secondaryAnimation.isDismissed}');
            // print(secondaryAnimation.isCompleted);
            return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(isRight ? -1 : 1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(isRight ? .6 : -.6, 0),
                      end: Offset.zero,
                    ).animate(ReverseAnimation(secondaryAnimation)),
                    child: child));
          },
        );
}

