import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/auth/login_contains.dart';
import 'package:project_manag_ite/view/widget/auth/register_contains.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class PageContentLoginRegister extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;

  const PageContentLoginRegister(
      {super.key, required this.currentIndex, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<LoginRegisterSwitcherControllerImp>();
    return PageView.builder(
      controller: pageController,
      itemCount: 2,
      onPageChanged: (index) {
        debugPrint(
            "im at PageContentLoginRegister at onPageChanged and index is $index andddd currentIndex is $currentIndex");
        controller.switchPage(index);
      },
      itemBuilder: (context, index) {
        return 
        
        
        LayoutBuilder(builder: (context, constraints) {
          double totalHeight = constraints.maxHeight;

          double bottomHeight = 500.h;
          double topHeight = totalHeight - bottomHeight;

          if (topHeight < 0) topHeight = 0;
          if (bottomHeight < 0) bottomHeight = 0;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: topHeight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(
                          () => CustomTitleText(
                              text: controller.currentIndex.value == 0
                                  ? 'تسجيل الدخول'
                                  : 'إنشاء حساب',
                              isTitle: true,
                              textAlign: TextAlign.right,
                              textColor: colors.subtitleText,
                              screenHeight: 880.sp),
                        ),
                        SizedBox(height: 5.h),
                        Obx(
                          () => CustomTitleText(
                            maxLines: 3,
                            text: controller.currentIndex.value == 0
                                ? 'مرحبا بك مجددا!\nسجل دخولك لمتابعة مشاريعك الجامعية\nولتنظيم المجموعات والتواصل معا'
                                : 'انضم الينا وابدأ رحلتك في تنظيم ومتابعة مشاريعك الجامعية في كلية الهندسة المعلوماتية وتواصل مع الأصدقاء والمشرفين',
                            isTitle: false,
                            textAlign: TextAlign.right,
                            textColor: colors.subtitleText,
                            screenHeight: 900.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: bottomHeight,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    decoration: BoxDecoration(
                      color: colors.backgroundWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70),
                      ),
                    ),
                    child: Obx(() {
                      return controller.currentIndex.value == 0
                          ? const LoginContains()
                          : const RegisterContains();
                    }),
                    //  controller.currentIndex == 0.obs
                    //     ? const LoginContains()
                    //     : const RegisterContains(),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
