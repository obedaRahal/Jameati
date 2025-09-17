import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicatorOnBoarding extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final Color activeDotColor;
  final Color dotColor;
  final Function(int)? onDotClicked;
  final double dotHeight;
  final double dotWidth;
  final double spacing;
  final double activeDotWidth;
  final TextDirection textDirection;

  // Constructor
  const CustomIndicatorOnBoarding(
      {super.key,
      required this.pageController,
      required this.pageCount,
      this.activeDotColor = AppColors.primary,
      this.dotColor = AppColors.grey,
      required this.onDotClicked,
      this.dotHeight = 15,
      this.dotWidth = 15,
      this.spacing = 30,
      this.textDirection = TextDirection.ltr, 
      this.activeDotWidth = 10
      });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      textDirection: textDirection,
      controller: pageController,
      count: pageCount,
      onDotClicked: onDotClicked,

      effect: CustomizableEffect(
        spacing: spacing,
        activeDotDecoration: DotDecoration(
          width: activeDotWidth, // 👈 عرض النقطة الفعالة الجديد
          height: dotHeight,
          color: activeDotColor,
          borderRadius: BorderRadius.circular(12),
        ),
        dotDecoration: DotDecoration(
          width: dotWidth,
          height: dotHeight,
          color: dotColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // effect: WormEffect(

      //   dotHeight: dotHeight,
      //   dotWidth: dotWidth,
      //   spacing: spacing,
      //   activeDotColor: activeDotColor,
      //   dotColor: dotColor,
      // ),
    );
  }
}
