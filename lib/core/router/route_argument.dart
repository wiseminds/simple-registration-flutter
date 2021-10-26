import 'package:flutter/material.dart';

typedef PageRouteBuilder RouteBuilder(Widget page, RouteSettings settings);

class RouteArgument {
  final RouteBuilder routeBuilder;

  RouteArgument(this.routeBuilder);
}
