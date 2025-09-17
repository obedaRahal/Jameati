
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class DoctorAndChangeDoctor extends StatelessWidget {
  const DoctorAndChangeDoctor({super.key, required this.onTap, required this.doctorName});
  final Function()? onTap;
  final String doctorName ;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBackgrondHome, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SvgPicture.asset(
                      MyImageAsset.groupPic,
                      height: 40.h,
                      width: 40.h,
                      fit: BoxFit.cover,
                    )),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 180.w,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CustomTitleText(
                      text: doctorName,
                      isTitle: true,
                      screenHeight: 450.sp,
                      textColor: colors.titleText,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                InkWell(
                  onTap: onTap,
                  child: CustomBackgroundWithWidget(
                      height: 30.h,
                      width: 80.w,
                      color: colors.greyBackgrondHome_darkPrimary,
                      borderRadius: 10,
                      alignment: Alignment.center,
                      child: CustomTitleText(
                        text: "تغيير الدكتور",
                        isTitle: true,
                        maxLines: 1,
                        screenHeight: 300.sp,
                        textAlign: TextAlign.center,
                        textColor: Get.find<ThemeController>().isDark
                            ? AppColors.black
                            : AppColors.greyHintDark,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
