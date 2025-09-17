
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/list_Spicialisation_widget.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class TeamLeaderWidget extends StatelessWidget {
  const TeamLeaderWidget(
      {super.key,
      required this.name,
      required this.stausStudents,
      required this.spicialisation,required this.onTap});

  final String name;
  final String stausStudents;
  final List<String> spicialisation;
  final Function()? onTap ;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    //final List<String> spicialisation = ["عام", "مشروع", "معلومات الغروب"];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        // Image.network(
                        //   group.image ?? "",
                        //   height: 70.h,
                        //   width: 65.w,
                        //   fit: BoxFit.cover,
                        //   errorBuilder: (context, error, stackTrace) {
                        //     return
                        SvgPicture.asset(
                      MyImageAsset.groupPic,
                      height: 70.h,
                      width: 65.w,
                      fit: BoxFit.cover,
                    )
                    //},
                    //),
                    ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: CustomTitleText(
                            text: name,
                            isTitle: true,
                            screenHeight: 500.sp,
                            textColor: colors.titleText,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ListSpicializationWidget(
                        spicialisation: spicialisation,
                        bgColor: colors.cyenToWhite_greyInputDark,
                        textColor: colors.primary_cyen,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomBackgroundWithWidget(
                      height: 26.h,
                      width: 70.w,
                      color: colors.greyBackgrondHome_darkPrimary,
                      borderRadius: 15,
                      child: Center(
                        child: Text(
                          stausStudents,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colors.titleText,
                            fontFamily: MyFonts.hekaya,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomBackgroundWithWidget(
                      height: 26.h,
                      width: 75.w,
                      color: colors.primary_cyen,
                      borderRadius: 15,
                      child: InkWell(
                        onTap: onTap,
                        child: Center(
                          child: Text(
                            "تغير المشرف",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colors.backgroundWhite,
                              fontFamily: MyFonts.hekaya,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}