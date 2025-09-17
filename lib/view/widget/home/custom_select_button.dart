import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class CustomSelectButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final CustomAppColors colors;
  final EdgeInsets? padding;
  final double? fontSize;

  const CustomSelectButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.colors,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDark;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.cyen : AppColors.cyenToWhite)
                : (isDark ? AppColors.darkPrimary : AppColors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: padding ??
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 0.h),
            child: CustomTitleText(
              text: text,
              isTitle: true,
              screenHeight: fontSize ?? 370.sp, // 👈 القيمة الافتراضية
              textAlign: TextAlign.center,
              textColor: isSelected
                  ? (isDark ? AppColors.black : AppColors.primary)
                  : AppColors.greyHintLight,
            ),
          ),
        ),
      ),
    );
  }
}
