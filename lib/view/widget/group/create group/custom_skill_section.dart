import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class CustomSkillSection extends StatelessWidget {
  final String title;
  final String skillsKey;
  final RxBool isExpanded;
  //final RxList<String> selectedSkills;
  final RxList<String> selectedFrameworkNeededSkills;
  final Map<String, List<String>> skillsBySpeciality;
  final RxList<String> selectedSpecialities;
  final int horizontalPadding;

  const CustomSkillSection(
      {super.key,
      required this.title,
      required this.skillsKey,
      required this.isExpanded,
      required this.selectedFrameworkNeededSkills,
      required this.skillsBySpeciality,
      required this.selectedSpecialities,
      this.horizontalPadding = 16});

  static const Map<String, String> displayToKey = {
    "UI/UX": "UI/UX",
    "فرونت ويب": "front_web",
    "فرونت موبايل": "front_mobile",
    "باك ايند": "Backend",
  };
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Obx(() {
      final key = displayToKey[title];
      final bool isActive = key != null && selectedSpecialities.contains(key);

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  size: 40.h,
                  isActive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: AppColors.greyHintDark,
                ),
                SizedBox(width: 6.w),
                const Expanded(
                  child:
                      Divider(thickness: 2, color: AppColors.greyBackgrondHome),
                ),
                SizedBox(width: 16.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: colors.cyenToWhite_greyInputDark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: colors.primary_cyen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // ✅ عرض المهارات عند التفعيل فقط
            if (isActive)
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: (skillsBySpeciality[skillsKey] ?? []).map((skill) {
                    final isSelected =
                        selectedFrameworkNeededSkills.contains(skill);

                    return GestureDetector(
                      onTap: () {
                        final currentSectionSkills =
                            skillsBySpeciality[skillsKey] ?? [];

                        selectedFrameworkNeededSkills.removeWhere(
                            (s) => currentSectionSkills.contains(s));

                        if (!isSelected) {
                          selectedFrameworkNeededSkills.add(skill);
                        }

                        debugPrint(
                            selectedFrameworkNeededSkills.toList().toString());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 35.w,
                            child: SvgPicture.asset("assets/icons/$skill.svg"),
                          ),
                          SizedBox(width: 5.w),
                          Container(
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    });
  }
}
