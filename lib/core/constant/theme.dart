
import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: MyFonts.hekaya,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
    extensions:  [CustomAppColors.light],
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: MyFonts.hekaya,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.darkPrimary,
    extensions:  [CustomAppColors.dark],
  );
}
