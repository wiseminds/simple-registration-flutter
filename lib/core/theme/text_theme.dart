import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme textTheme({required String font, required Color color}) =>
      TextTheme( 
          caption: TextStyle(
            fontFamily: font,
            color: color,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
              fontFamily: font,
              color: color,
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              fontFamily: font,
              color: color.withOpacity(.6),
              fontWeight: FontWeight.w400),
          headline5: TextStyle(
              fontFamily: font,
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.w700),
          headline4: TextStyle(
              fontFamily: font,
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.w700),
          headline3: TextStyle(
              fontFamily: font,
              fontSize: 32,
              color: color,
              fontWeight: FontWeight.w700));
}
