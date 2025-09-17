import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class FormSubmitWidget extends StatelessWidget {
  //final double heightMediaQ;
  final String imageAsset;
  final String titleText;
  final String dayCount;
  final String dayOrMonth;
  final String startDate;
  final String endDate;

  const FormSubmitWidget({
    super.key,
    //required this.heightMediaQ,
    required this.imageAsset,
    required this.titleText,
    required this.dayCount,
    required this.dayOrMonth,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBackgroundWithWidget(
          height: 85.h,
          width: 350.w,
          color: colors.greyBackgrondHome_darkPrimary,
          borderRadius: 50,
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5.w),
                      alignment: Alignment.bottomCenter,
                      height: 65.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colors.primary_cyen,
                      ),
                      child: CustomTitleText(
                        text: dayOrMonth,
                        isTitle: false,
                        screenHeight: 700.sp,
                        textColor: colors.backgroundWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      left: 22.h,
                      bottom: 12.w,
                      child: CustomTitleText(
                        text: dayCount,
                        isTitle: true,
                        screenHeight: 700.h,
                        textColor: colors.backgroundWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 200.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: CustomTitleText(
                            text: titleText,
                            isTitle: true,
                            screenHeight: 400.sp,
                            textColor: colors.titleText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 200.w,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomBackgroundWithWidget(
                          height: 30.h,
                          width: 200.w,
                          color: Get.find<ThemeController>().isDark
                              ? const Color(0xff3F3F3F)
                              : AppColors.greyInput,
                          borderRadius: 30,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  endDate,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: MyFonts.hekaya,
                                    color: AppColors.greyHintDark,
                                  ),
                                ),
                                Text(
                                  "انتهاء | ",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: MyFonts.hekaya,
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  startDate,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: MyFonts.hekaya,
                                    color: AppColors.greyHintDark,
                                  ),
                                ),
                                Text(
                                  " بدء ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SvgPicture.asset(
                  imageAsset,
                  height: 32.h,
                ),
                SizedBox(
                  width: 3.w,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
