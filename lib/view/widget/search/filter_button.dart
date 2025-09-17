
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/home/custom_select_button.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return CustomSelectButton(
      colors: colors,
      text: text,
      fontSize: 390.sp,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 1.h),
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}