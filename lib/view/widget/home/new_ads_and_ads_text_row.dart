import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class NewAdsAndAdsTextRow extends StatelessWidget {
  const NewAdsAndAdsTextRow(
      {super.key,
      required this.colors,
      required this.title,
      required this.numOfAdv,
      required this.text});
  final CustomAppColors colors;
  final String text;
  final String title;
  final String numOfAdv;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackgroundWithWidget(
          height: 36.h,
          width: 100.w,
          color: Get.find<ThemeController>().isDark
              ? AppColors.darkPrimary
              : AppColors.redPink,
          borderRadius: 30,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTitleText(
                  text: title,
                  isTitle: true,
                  screenHeight: 320.sp,
                  textColor: colors.titleText,
                  horizontalPadding: 0,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 8.w),
                CustomBackgroundWithWidget(
                  height: 26.h,
                  width: 26.h,
                  color: AppColors.red,
                  borderRadius: 30,
                  child: Center(
                    child: CustomTitleText(
                      text: numOfAdv,
                      isTitle: true,
                      screenHeight: 300.sp,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.black
                          : AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
               // SizedBox(width: 6.w),
              ],
            ),
          ),
        ),
        const Spacer(),
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
