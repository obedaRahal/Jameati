// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'package:flutter/material.dart';

// class AppColors {
//   static const primary = Color(0XFF29B6F6);
//   static const darkPrimary = Color(0XFF121212);

//   static const white = Color(0XFFFFFFFF);
//   static const black = Color(0XFF121212);
//   static const grey = Color(0XFFF5F5F5);

//   //LOG IN AND REG
//   static const greyInput = Color(0XFFE7E7E7);
//   static const greyInputDark = Color(0XFF2F2F2F);

//   static const greyHintLight = Color(0XFFACACAC);
//   static const greyHintDark = Color(0XFF7E7E7E);
//   static const greyWithBlack = Color(0XFF484848);

//   //forget   password
//   static const cyenToWhite = Color(0XFFE2F4FC);
//   static const cyen = Color(0XFF81d4fa);
//   static const red = Color.fromARGB(255, 206, 69, 69);
// }

class AppColors {
  static const primary = Color(0xFF29B6F6);
  static const darkPrimary = Color(0xFF2F2F2F);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF121212);
  static const grey = Color(0xFFF5F5F5);

  static const greyWithBlack = Color(0xFF484848);

  static const greyHintLight = Color(0xFFACACAC);
  static const greyHintDark = Color(0xFF7E7E7E);

  static const cyen = Color(0xFF81d4fa);
  static const cyenToWhite = Color(0xFFE2F4FC);

  static const greyInput = Color(0xFFE7E7E7);
  static const greyInputDark = Color(0xFF2F2F2F);

  static const textDark = Color(0xFFC2C2C2);

  static const red = Color(0xffff5757);

  static const green = Color(0xff69D447);

  //home
  static const redPink = Color(0xffFFD6D6);
  static const yellow = Color(0xffF6BF29);
  static const yellowWhite = Color(0xffFCF6E2);

  static const greyBackgrondHome = Color(0xfff1f1f1);




}

class CustomAppColors extends ThemeExtension<CustomAppColors> {
  final Color backgroundWhite;
  final Color titleText;
  final Color subtitleText;
  final Color mainColor;

  final Color greyInputDark_greyWithBlack;
  final Color white_textDark;
  final Color white_cyen;
  final Color greyInputDark_darkPrimary;

  // login register
  final Color cyenToWhite_greyInputDark;
  final Color primary_cyen;
  final Color greyHint_authTabUnselectedText;
  final Color greyInput_greyInputDark;

  //home
  final Color greyBackgrondHome_darkPrimary;

  //  Shimmer colors
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color shimmerItem;


  const CustomAppColors(
      {required this.backgroundWhite,
      required this.titleText,
      required this.subtitleText,
      required this.mainColor,
      required this.greyInputDark_greyWithBlack,
      required this.white_textDark,
      required this.white_cyen,
      required this.greyInputDark_darkPrimary,
      required this.cyenToWhite_greyInputDark,
      required this.greyHint_authTabUnselectedText,
      required this.primary_cyen,
      required this.greyInput_greyInputDark , 
      required this.greyBackgrondHome_darkPrimary, 

      required this.shimmerBase,
    required this.shimmerHighlight,
    required this.shimmerItem,
      });

  @override
  CustomAppColors copyWith({
    Color? background,
    Color? titleText,
    Color? subtitleText,
    Color? mainColor,

    Color? greyInputDark_greyWithBlack,
    Color? white_textDark,
    Color? white_cyen,
    Color? greyInputDark_darkPrimary,
    
    Color? cyenToWhite_greyInputDark,
    Color? primary_cyen,
    Color? greyHint_authTabUnselectedText,
    Color? greyInput_greyInputDark,

    Color? greyBackgrondHome_darkPrimary,

    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? shimmerItem,

  }) {
    return CustomAppColors(
      backgroundWhite: background ?? this.backgroundWhite,
      titleText: titleText ?? this.titleText,
      subtitleText: subtitleText ?? this.subtitleText,
      mainColor: mainColor ?? this.mainColor,
      greyInputDark_greyWithBlack:
          greyInputDark_greyWithBlack ?? this.greyInputDark_greyWithBlack,
      white_textDark: white_textDark ?? this.white_textDark,
      white_cyen: white_cyen ?? this.white_cyen,
      greyInputDark_darkPrimary: greyInputDark_darkPrimary ?? this.greyInputDark_darkPrimary,
      cyenToWhite_greyInputDark:
          cyenToWhite_greyInputDark ?? this.cyenToWhite_greyInputDark,

      // greyHint_authTabUnselectedText:primary_cyen ?? this.greyHint_authTabUnselectedText,
      // primary_cyen: greyHint_authTabUnselectedText ?? this.primary_cyen,
      greyHint_authTabUnselectedText: greyHint_authTabUnselectedText ?? this.greyHint_authTabUnselectedText,
primary_cyen: primary_cyen ?? this.primary_cyen,

      greyInput_greyInputDark: greyInput_greyInputDark ?? this.greyInput_greyInputDark,

      greyBackgrondHome_darkPrimary: greyBackgrondHome_darkPrimary ?? this.greyBackgrondHome_darkPrimary,

      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      shimmerItem: shimmerItem ?? this.shimmerItem,

    );
  }

  @override
  CustomAppColors lerp(ThemeExtension<CustomAppColors>? other, double t) {
    if (other is! CustomAppColors) return this;
    return CustomAppColors(
      backgroundWhite: Color.lerp(backgroundWhite, other.backgroundWhite, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      subtitleText: Color.lerp(subtitleText, other.subtitleText, t)!,
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      greyInputDark_greyWithBlack: Color.lerp(
          greyInputDark_greyWithBlack, other.greyInputDark_greyWithBlack, t)!,
      white_textDark: Color.lerp(white_textDark, other.white_textDark, t)!,
      white_cyen: Color.lerp(white_cyen, other.white_cyen, t)!,
      greyInputDark_darkPrimary: Color.lerp(
          greyInputDark_darkPrimary, other.greyInputDark_darkPrimary, t)!,
      cyenToWhite_greyInputDark: Color.lerp(
          cyenToWhite_greyInputDark, other.cyenToWhite_greyInputDark, t)!,
      greyHint_authTabUnselectedText: Color.lerp(greyHint_authTabUnselectedText,
          other.greyHint_authTabUnselectedText, t)!,
      primary_cyen: Color.lerp(primary_cyen, other.primary_cyen, t)!,
      greyInput_greyInputDark: Color.lerp(
          greyInput_greyInputDark, other.greyInput_greyInputDark, t)!,

          greyBackgrondHome_darkPrimary: Color.lerp(
    greyBackgrondHome_darkPrimary, other.greyBackgrondHome_darkPrimary, t)!,


     shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      shimmerItem: Color.lerp(shimmerItem, other.shimmerItem, t)!,

    );
  }

  static final light = CustomAppColors(
      backgroundWhite: AppColors.white,
      titleText: AppColors.black,
      subtitleText: AppColors.white,
      mainColor: AppColors.primary,
      greyInputDark_greyWithBlack: AppColors.greyInputDark,
      white_textDark: AppColors.white,
      white_cyen: AppColors.white,
      greyInputDark_darkPrimary: AppColors.greyInputDark,
      cyenToWhite_greyInputDark:
          AppColors.cyenToWhite, // ✅ لون الخلفية عند التحديد
      primary_cyen:
          AppColors.primary, // ✅ لون النص عند التحديد
      greyHint_authTabUnselectedText: AppColors.greyHintLight, // ✅ لون النص عند عدم التحديد

      greyInput_greyInputDark: AppColors.greyInput , 
      greyBackgrondHome_darkPrimary: AppColors.greyBackgrondHome,

      shimmerBase: Colors.grey.shade300,
shimmerHighlight: Colors.grey.shade100,
shimmerItem: Colors.white,

);

      

  static final dark = CustomAppColors(
      backgroundWhite: AppColors.black,
      titleText: AppColors.textDark,
      subtitleText: AppColors.textDark,
      mainColor: AppColors.darkPrimary,
      greyInputDark_greyWithBlack: AppColors.greyWithBlack,
      white_textDark: AppColors.textDark,
      white_cyen: AppColors.cyen,
      greyInputDark_darkPrimary: AppColors.darkPrimary,
      cyenToWhite_greyInputDark: AppColors.greyInputDark, // ✅ خلفية التحديد
      primary_cyen: AppColors.cyen, // ✅ لون النص عند التحديد
      greyHint_authTabUnselectedText: AppColors.greyHintDark, // ✅ لون النص عند عدم التحديد

      greyInput_greyInputDark: AppColors.greyInputDark,
      greyBackgrondHome_darkPrimary: AppColors.darkPrimary,

      shimmerBase: Colors.grey.shade700,
shimmerHighlight: Colors.grey.shade500,
shimmerItem: Colors.grey.shade600,

);
}
