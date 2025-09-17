
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class TimerAndJoinReqestRow extends StatelessWidget {
  const TimerAndJoinReqestRow({super.key, required this.onTap, required this.timeOfInterview});
  final Function()? onTap;
  final String timeOfInterview ;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          child: CustomBackgroundWithWidget(
              height: 36.h,
              width: 130.w,
              color: colors.primary_cyen,
              borderRadius: 10,
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTitleText(
                      //shorizontalPadding: 5.h,
                      text: "طلبات الانضمام",
                      isTitle: true,
                      maxLines: 1,
                      screenHeight: 300.sp,
                      textAlign: TextAlign.center,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.black
                          : AppColors.white,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      color: Get.find<ThemeController>().isDark
                          ? AppColors.black
                          : AppColors.white,
                      size: 23.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
              )),
        ),
        CustomBackgroundWithWidget(
            height: 36.h,
            width: 190.w,
            color: colors.greyBackgrondHome_darkPrimary,
            borderRadius: 10,
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTitleText(
                    //shorizontalPadding: 5.h,
                    text: timeOfInterview,
                    isTitle: true,
                    maxLines: 1,
                    screenHeight: 300.sp,
                    textAlign: TextAlign.center,
                    textColor: AppColors.greyHintLight,
                  ),
                  Icon(
                    Icons.timer_outlined,
                    color: AppColors.greyHintLight,
                    size: 25.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
