import 'package:challenge/constants/app_colors.dart';
import 'package:challenge/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'input_decoration.dart';
import 'text_theme.dart';

class AppTheme {
  String get font => Fonts.inter;
  Color get primary => AppColors.primary;
  Color get backgroundColor => AppColors.backgroundColorLight;
  Color get backgroundColorDark => AppColors.backgroundColorDark;
  Color get cardColor => AppColors.cardColorLight;
  Color get cardColorDark => AppColors.cardColorDark;

  InputDecorationTheme get inputDecorationTheme =>
      AppInputDecoration.inputDecoration(
          color: AppColors.borderColor, font: font, primary: primary);

  InputDecorationTheme get inputDecorationThemeDark =>
      AppInputDecoration.inputDecoration(
          color: Colors.white, font: font, primary: Colors.white);

  TextTheme get _textThemeDark =>
      AppTextTheme.textTheme(color: Colors.white, font: font);
  TextTheme get _textThemeLight =>
      AppTextTheme.textTheme(color: AppColors.textBlack, font: font);

  ThemeData get dark => ThemeData.dark().copyWith(
      primaryColor: primary,
      textTheme: _textThemeDark,
      cardColor: AppColors.cardColorDark,
      canvasColor: AppColors.canvasColorDark,
      backgroundColor: backgroundColorDark,
      inputDecorationTheme: inputDecorationThemeDark);

  ThemeData get light => ThemeData.light().copyWith(
      // primaryTextTheme: textTheme,
      textTheme: _textThemeLight,
      primaryColor: primary,
      backgroundColor: backgroundColor,
      inputDecorationTheme: inputDecorationTheme);
}
