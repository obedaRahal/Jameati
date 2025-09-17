
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';

class CustomGroupTabSwitcher extends StatelessWidget {
  const CustomGroupTabSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateNewGroupControllerImp>();
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildTab(
            index: 1,
            isSelected: controller.selectedTab.value == 1,
            label: "دعوة أعضاء",
            iconPath: Icons.group_add, // 🔁 ضع المسار الصحيح
            onTap: () => controller.changeTab(1),
            colors: colors,
          ),
          SizedBox(width: 20.w),
          _buildTab(
            index: 0,
            isSelected: controller.selectedTab.value == 0,
            label: "معلومات الغروب",
            iconPath: Icons.list_alt, // 🔁 ضع المسار الصحيح
            onTap: () => controller.changeTab(0),
            colors: colors,
          ),
        ],
      );
    });
  }

  Widget _buildTab({
    required int index,
    required bool isSelected,
    required String label,
    required IconData iconPath,
    required VoidCallback onTap,
    required CustomAppColors colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFonts.hekaya,
                  fontSize: 20.sp,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(top: 4.h),
                height: 2,
                width: isSelected ? 90.w : 40.w,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ],
          ),
          SizedBox(width: 4.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              iconPath,
              size: 30.h,
              color: isSelected ? AppColors.white : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
