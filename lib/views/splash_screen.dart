import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigate();
    super.initState();
  }

  // navigate after app setup
  void _navigate() {
    // Navigator.
  }
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(child: FlutterLogo()),
    );
  }
}
