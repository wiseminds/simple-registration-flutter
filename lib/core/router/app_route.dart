import 'package:flutter/material.dart';

/// base class for page with a route name
abstract class AppRoute {
  /// route name for particular route
  static String get routeName => '';

  String get route;

  /// instance  of this page
  Widget get page;
}
