import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/auth/page_content_login_register.dart';
import 'package:project_manag_ite/view/widget/common/back_with_text.dart';

class LoginRegisterSwitcher extends StatelessWidget {
  const LoginRegisterSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    //final controller = Get.put(LoginRegisterSwitcherControllerImp());
    final controller = Get.find<LoginRegisterSwitcherControllerImp>();
    return Scaffold(
      backgroundColor: colors.mainColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: BackWithText(
                      onTap: () => Get.back(),
                      iconColor: colors.subtitleText,
                      textColor: colors.subtitleText,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Obx(
                      () {
                        return PageContentLoginRegister(
                          pageController: controller.pageController,
                          currentIndex: controller.currentIndex.value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
