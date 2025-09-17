import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_indicator.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class CustomIndicatorWithTextRow extends StatelessWidget {
  const CustomIndicatorWithTextRow({
    super.key,
    required this.pageController,
    //required this.heightMediaQ,
    required this.text,
    this.pageCount = 3,
    this.textDirection  = TextDirection.ltr
  });

  final PageController pageController;
  //final double heightMediaQ;
  final String text;
  final int pageCount;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
        final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 15.w),
          child: CustomIndicatorOnBoarding(
            pageController: pageController,
            pageCount: pageCount,
            onDotClicked: (p0) {},
            dotHeight: 8,
            dotWidth: 8,
            spacing: 10,
            activeDotWidth: 20,
            textDirection: textDirection,
            dotColor: colors.greyBackgrondHome_darkPrimary,
            activeDotColor:colors.primary_cyen,
          ),
        ),
        CustomTitleText(
            text: text,
            isTitle: true,
            screenHeight: 600.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center)
      ],
    );
  }
}
