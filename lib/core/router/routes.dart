import 'package:challenge/views/account/phone_verification_screen.dart';
import 'package:challenge/views/account/register_screen.dart';
import 'package:challenge/views/account/welcome_screen.dart';

import 'app_route.dart';

class Routes {
  static const all = <AppRoute>[
    WelcomeScreen(),
    PhoneVerificationScreen(),
    RegisterScreen()
  ];
}
