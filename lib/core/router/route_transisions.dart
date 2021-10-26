import 'package:flutter/cupertino.dart';

import 'transissions/fade_route.dart';
import 'transissions/slide_side_route.dart';
import 'transissions/slide_up_route.dart';

typedef RouteBuilder = Route Function(RouteSettings settings);
enum Transissions { fade, fadeScale, slideRight, slideLeft, slideUp }

class RouteTransissions {
  static Route<dynamic> build(
      Transissions transission, RouteSettings settings, Widget page) {
    switch (transission) {
      case Transissions.slideRight:
        return SlideSideRoute(settings: settings, page: page, isRight: true);
      case Transissions.slideLeft:
        return CupertinoPageRoute(
          builder: (c) => page,
          settings: settings,
        );
      case Transissions.slideUp:
        return SlideUpRoute(settings: settings, page: page);
      default:
        return FadeRoute(settings: settings, page: page);
    }
  }
}
