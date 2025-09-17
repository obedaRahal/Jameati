import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/common/back_with_text.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/create_group_info.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/custom_group_tap_switcher.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/invite_people.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class CreateNewGroupScreen extends StatelessWidget {
  const CreateNewGroupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<CreateNewGroupControllerImp>();

    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h, left: 18.h, right: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackWithText(
                  onTap: () => Get.back(),
                  iconColor: colors.titleText,
                  textColor: colors.titleText,
                  text: "",
                ),
                CustomTitleText(
                  text: "انشاء غروب ",
                  isTitle: true,
                  screenHeight: 800.sp,
                  textColor: colors.titleText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.h),
            child: const CustomGroupTabSwitcher(),
          ),
          SizedBox(
            height: 12.h,
          ),
          Material(
            elevation: 8,
            color: Get.find<ThemeController>().isDark
                ? AppColors.darkPrimary
                : AppColors.white,
            shadowColor: Colors.black.withOpacity(0.2),
            child: Divider(
              height: 8.h,
              color: colors.greyInput_greyInputDark,
              thickness: 2,
            ),
          ),
          // Expanded(child:
          // )

          Obx(() => controller.selectedTab.value == 0
              ? const Expanded(
                  child: SingleChildScrollView(
                  child: CreateInfoGroup(),
                ))
              : InvitePeopleToCreateGroup())
        ],
      ),
    ));
  }
}
