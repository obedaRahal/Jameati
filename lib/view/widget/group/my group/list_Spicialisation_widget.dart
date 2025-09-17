
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ListSpicializationWidget extends StatelessWidget {
  const ListSpicializationWidget({
    super.key,
    required this.spicialisation,
    required this.bgColor,
    required this.textColor,
    this.width = 190,
  });

  final List<String> spicialisation;
  final Color bgColor;
  final Color textColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      //height: 50.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: spicialisation.map((tag) {
            return Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: CustomBackgroundWithWidget(
                height: 25.h,
                width: 90.w,
                color: bgColor,
                borderRadius: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: CustomTitleText(
                    text: "# $tag",
                    isTitle: false,
                    screenHeight: 550.sp,
                    textColor: textColor,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
