
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_button.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<LoginRegisterSwitcherControllerImp>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h), // .02 * 873 ≈ 17.46
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Get.find<ThemeController>().isDark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      onPressed: () => Get.find<ThemeController>().toggleTheme(),
                    ),
                    const Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "ج",
                            style: TextStyle(
                              color: colors.primary_cyen,
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFonts.hekaya,
                              fontSize: 30.sp,
                            ),
                          ),
                          TextSpan(
                            text: "امعتي",
                            style: TextStyle(
                              color: colors.titleText,
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFonts.hekaya,
                              fontSize: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      MyImageAsset.feather,
                      height: 45.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              SvgPicture.asset(
                MyImageAsset.welcome,
                height: 260.h,
              ),
              CustomTitleText(
                textAlign: TextAlign.center,
                text: "! مرحبا بك",
                isTitle: true,
                screenHeight: 950.sp,
                textColor: colors.titleText,
              ),
              SizedBox(height: 10.h),
              CustomTitleText(
                textAlign: TextAlign.center,
                text: "تطبيق يساعد الطلاب على\nتنظيم , متابعة , وتسليم مشاريعهم\nالجامعية بكفاءة وسهولة",
                isTitle: false,
                screenHeight: 900.sp,
                textColor: colors.titleText,
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w), // .02 * 873 ≈ 17.4
                height: 165.h, // .19 * 873 ≈ 165.87
                decoration: BoxDecoration(
                  color: colors.mainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(65.r),
                    topRight: Radius.circular(65.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButtonOnBoarding(
                      text: "تسجيل الدخول",
                      textColor: colors.white_textDark,
                      buttonColor: colors.greyInputDark_greyWithBlack,
                      fontSize: 18.sp, // .025 * 873 ≈ 21.8
                      paddingVertical: 8.h,
                      onPressed: () {
                        controller.switchPage(0);
                        Get.toNamed(AppRoute.loginregister);
                      },
                    ),
                    CustomButtonOnBoarding(
                      text: "حساب جديد",
                      textColor: colors.greyInputDark_darkPrimary,
                      buttonColor: colors.white_cyen,
                      fontSize: 18.sp, // .025 * 873 ≈ 21.8
                      paddingVertical: 8.h,
                      onPressed: () {
                        controller.switchPage(1);
                        Get.toNamed(AppRoute.loginregister);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
