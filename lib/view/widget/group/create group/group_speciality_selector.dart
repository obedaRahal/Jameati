import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';

class GroupSpecialitySelector extends StatelessWidget {
  const GroupSpecialitySelector({super.key});
  

  static const Map<String, String> specialitiesMap = {
    "UI/UX": "UI/UX",
    "فرونت ويب": "front_web",
    "فرونت موبايل": "front_mobile",
    "باك ايند": "Backend",
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateNewGroupControllerImp>();
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Obx(() {
      return Wrap(
        spacing: 8.w,
        //runSpacing: 8.h,
        children: specialitiesMap.entries.map((entry) {
          final displayName = entry.key; // "فرونت موبايل"
          final actualValue = entry.value; // "frontMobile"

          final isSelected =
              controller.selectedSpecialities.contains(actualValue);

          return GestureDetector(
            onTap: () {
              controller.toggleSpeciality(actualValue);
              debugPrint(actualValue);
              debugPrint(controller.selectedSpecialities.toList().toString());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : colors.greyInput_greyInputDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                displayName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: MyFonts.hekaya,
                  color: isSelected ? Colors.white : AppColors.greyHintLight,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
