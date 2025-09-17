
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class TextIconChip extends StatelessWidget {
  final double backgroundHeight; // مثال: 26.h
  final double backgroundWidth; // مثال: 75.w
  final IconData icon;
  final String text;
  final Color textIconColor;

  final double borderRadius;

  final Color? backgroundColor;
  final Function()? onTap;

  const TextIconChip({
    super.key,
    required this.backgroundHeight,
    required this.backgroundWidth,
    required this.icon,
    required this.text,
    required this.textIconColor,
    this.borderRadius = 16,
    this.backgroundColor,
    required this.onTap, // مرّره لو حبيت تغيّر اللون
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return InkWell(
      onTap: onTap,
      child: CustomBackgroundWithWidget(
        height: backgroundHeight.h,
        width: backgroundWidth.w,
        color: backgroundColor ?? colors.greyBackgrondHome_darkPrimary,
        borderRadius: borderRadius,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: textIconColor,
                size: 25.h,
              ),
              CustomTitleText(
                horizontalPadding: 5.h,
                text: text,
                isTitle: true,
                maxLines: 1,
                screenHeight: 300.sp,
                textAlign: TextAlign.center,
                textColor: textIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
