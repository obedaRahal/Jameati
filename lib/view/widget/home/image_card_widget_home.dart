
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ImageCardWidget extends StatelessWidget {
  final Color backgroundColor;
  final String iconAsset;
  final String numberText;
  final Color backgroundNumberText;
  final String titleText;
  final Color titleTextColor;
  final String imageAsset;
  //final double heightMediaQ;

  const ImageCardWidget({
    super.key,
    required this.backgroundColor,
    required this.iconAsset,
    required this.numberText,
    required this.titleText,
    required this.titleTextColor,
    required this.imageAsset,
   // required this.heightMediaQ,
    required this.backgroundNumberText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundWithWidget(
      height: 170.h,
      width: 170.w,
      color: backgroundColor,
      borderRadius: 30,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomBackgroundWithWidget(
                      height: 25.h,
                      width: 50.w,
                      color: backgroundNumberText,
                      borderRadius: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            iconAsset,
                            fit: BoxFit.cover,
                            height: 16.h,
                          ),
                          CustomTitleText(
                            text: numberText,
                            isTitle: true,
                            screenHeight: 280.sp,
                            textColor: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTitleText(
                    text: titleText,
                    isTitle: true,
                    screenHeight: 500.sp,
                    textColor: titleTextColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SvgPicture.asset(
                imageAsset,
                height: 120.h,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        ),
      ),
    );
  }
}
