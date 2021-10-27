import 'package:challenge/constants/dimens.dart';
import 'package:challenge/core/router/app_route.dart';
import 'package:challenge/core/router/route_transisions.dart';
import 'package:challenge/views/account/register_screen.dart';
import 'package:challenge/widgets/medium_button.dart';
import 'package:flutter/material.dart';
import 'package:challenge/core/extensions/index.dart';

import 'phone_verification_screen.dart';

class WelcomeScreen extends StatelessWidget implements AppRoute {
  static String get routeName => 'welcome';

  @override
  Widget get page => this;

  @override
  String get route => routeName;

  const WelcomeScreen({Key? key}) : super(key: key);

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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      PhoneVerificationScreen.routeName,
                      arguments: Transissions.slideLeft);
                },
              ),
              20.0.h,
            ],
          ),
        ),
      ),
    );
  }
}
