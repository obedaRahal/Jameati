import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';

class FormSubmitShimmer extends StatelessWidget {
  const FormSubmitShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBackgroundWithWidget(
          height: 85.h,
          width: 350.w,
          color: colors.greyBackgrondHome_darkPrimary,
          borderRadius: 50,
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: Shimmer.fromColors(
              baseColor: colors.shimmerBase, // ✅ لون مخصص للوضع الحالي
              highlightColor: colors.shimmerHighlight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // الدائرة اليمنى
                  Container(
                    height: 65.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Get.find<ThemeController>().isDark
                          ? Colors.grey.shade600
                          : Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  // النصوص
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 200.w,
                        height: 20.h,
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8.h),
                      ),
                      Container(
                        width: 200.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),

                  // الأيقونة اليسرى
                  Container(
                    width: 32.h,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 3.w),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
