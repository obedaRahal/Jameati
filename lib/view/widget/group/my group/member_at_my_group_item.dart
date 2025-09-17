
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/list_Spicialisation_widget.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class MemberAtMyGroupItem extends StatelessWidget {
  const MemberAtMyGroupItem(
      {super.key, required this.name, required this.spicialisation});

  final String name;
  final List<String> spicialisation;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        width: 260.w,
                        spicialisation: spicialisation,
                        bgColor: colors.cyenToWhite_greyInputDark,
                        textColor: colors.primary_cyen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
