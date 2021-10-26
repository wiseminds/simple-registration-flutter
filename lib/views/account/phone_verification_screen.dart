import 'package:flutter/material.dart';

import 'package:challenge/constants/dimens.dart';
import 'package:challenge/core/router/app_route.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:challenge/core/extensions/index.dart';

class PhoneVerificationScreen extends StatelessWidget implements AppRoute {
  static String get routeName => 'phone-verification';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingNormal),
          child: Column(
            children: [
              100.0.h,
              const FlutterLogo(size: 100),
              30.0.h,
              Text('Welcome to Flutter challenge app',
                  style: context.headline5),
              .0.s,
              MediumButton(
                label: 'Get Started',
                onPressed: () {},
              ),
              20.0.h,
            ],
          ),
        ),
      ),
    );
  }
}
