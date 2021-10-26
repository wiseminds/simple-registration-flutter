import 'package:flutter/material.dart';

class AppInputDecoration {
  static InputDecorationTheme inputDecoration(
          {required String font, required Color color}) =>
      InputDecorationTheme(
          floatingLabelStyle: TextStyle(
              fontFamily: font,
              color: color,
              fontSize: 18,
              height: 0.0,
              fontWeight: FontWeight.w500),
          errorMaxLines: 1,
          isCollapsed: true, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.5),
          helperMaxLines: 3,
          prefixStyle: TextStyle(
              fontFamily: font,
              color: color.withOpacity(.7),
              fontWeight: FontWeight.w400),
          focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 3)),
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: color.withOpacity(.9))),
          errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: color.withOpacity(.8), width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: color.withOpacity(.9), width: 3)));
}
