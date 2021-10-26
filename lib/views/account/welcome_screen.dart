import 'package:challenge/core/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:challenge/core/extensions/index.dart';

class WelcomeScreen extends StatelessWidget  implements AppRoute {
  static String get routeName => 'welcome';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(children: [
          100.0.h,
        ],),
      ),
      
    );
  }
}