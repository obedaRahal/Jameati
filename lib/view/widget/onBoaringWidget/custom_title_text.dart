import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class CustomTitleText extends StatelessWidget {
  final String text;
  final bool isTitle;
  //final bool isCenter;
  final double screenHeight;
  final int maxLines;
  final Color textColor;
  final TextAlign textAlign;
  final double horizontalPadding;

  const CustomTitleText({
    super.key,
    required this.text,
    required this.isTitle,
    //required this.isCenter,
    required this.screenHeight,
    this.textColor=AppColors.darkPrimary,
    required this.textAlign,
    this.maxLines=5,
    this.horizontalPadding=0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        maxLines: maxLines,
        text,
        textAlign: textAlign,
        style: TextStyle(
        //decorationThickness: 40,
        
          color :textColor,
          fontSize: isTitle 
              ? screenHeight * 0.05 
              : screenHeight * 0.025,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
