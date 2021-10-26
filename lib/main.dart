import 'package:challenge/core/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'core/router/app_router.dart';
import 'core/router/routes.dart';
import 'core/theme/app_theme.dart';
import 'dependency_injection.dart';
import 'env.example.dart';
import 'views/splash_screen.dart';

void main() async {
  await DependencyInjection.setUp(

      /// use prodcution env for release builds and development env for development build
      (kDebugMode ? Development(ENV) : Production(ENV)));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

        /// used to dismiss key pad when the user taps on the screen outside the keypad
        onTap: () =>
            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: Strings.appTitle,
          theme: AppTheme().light,
          darkTheme: AppTheme().dark,
          home: const SplashScreen(),
          onGenerateRoute: AppRouter(Routes.all).onGenerateRoute,
          navigatorKey: AppRouter.navigationKey,
        ));
  }
}
