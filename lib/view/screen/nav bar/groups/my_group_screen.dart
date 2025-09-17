import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/genral_info_screen_part.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/info_of_group_screen_part.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/project_screen_part.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
import 'package:project_manag_ite/view/widget/search/filter_button.dart';

class MyGroupScreen extends StatelessWidget {
  const MyGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<MyGroupControllerImp>();

    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(
        top: 18.h,
        left: 18.h,
        right: 18.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTitleText(
              text: "غروبي",
              isTitle: true,
              screenHeight: 800.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            Obx(() => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: controller.screenPart.map((filter) {
                          return FilterButton(
                            text: filter,
                            isSelected:
                                controller.selectedScreenPart.value == filter,
                            onTap: () {
                              controller.selectedScreenPart.value = filter;
                              debugPrint("تم اختيار : $filter");
                            },
                          );
                        }).toList(),
                      )),
                )),
            Divider(
              color: colors.greyInput_greyInputDark,
              thickness: 2,
            ),
            Obx(() => controller.selectedScreenPart.value == "عام"
                ? const GeneralInfoScreenPart()
                : controller.selectedScreenPart.value == "مشروع"
                    ? const ProjectScreenPart()
                    : const InfoOfGroupScreenPart())
          ],
        ),
      ),
    ));
  }
}

