
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class SearchHistoryItem extends StatelessWidget {
  final String item;
  final VoidCallback onRemove;

  const SearchHistoryItem({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .extension<CustomAppColors>()!
            .greyInput_greyInputDark,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 20.sp,
              color: isDark
                  ? AppColors.grey.withOpacity(0.75)
                  : AppColors.greyHintDark.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            item,
            style: TextStyle(
              color: AppColors.greyHintLight.withOpacity(0.75),
              fontSize: 20.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.history_rounded,
            size: 20.sp,
            color: isDark
                ? AppColors.grey.withOpacity(0.75)
                : AppColors.greyHintDark.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
