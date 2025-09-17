
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class IconTitleInfoRow extends StatelessWidget {
  const IconTitleInfoRow(
      {super.key,
      required this.icon,
      required this.title,
      required this.info,
      this.width = 260 , 
      this.titleColor = AppColors.greyHintLight,
      this.infoColor = AppColors.primary
      });

  final IconData icon;
  final String title;
  final Color titleColor;
  final String info;
  final Color infoColor;
  final int width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(
              icon,
              color: titleColor,
              size: 25.h,
            ),
            SizedBox(
              width: 6.w,
            ),
            CustomTitleText(
              text: title,
              isTitle: true,
              screenHeight: 350.sp,
              textColor: titleColor,
              textAlign: TextAlign.right,
              maxLines: 1,
            ),
            CustomTitleText(
              text: info,
              isTitle: true,
              screenHeight: 400.sp,
              textColor: infoColor,
              textAlign: TextAlign.right,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
