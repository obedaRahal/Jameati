
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/icon_title_info_row.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/text_icon_chip.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class MyProjectAndDownloadBottun extends StatelessWidget {
  const MyProjectAndDownloadBottun({super.key, required this.onTap, required this.projectName, required this.historyOfCreate, required this.numOfAssign});

  final Function()? onTap;
  final String projectName ;
  final String historyOfCreate ;
  final int numOfAssign ;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackgroundWithWidget(
              height: 100.h,
              width: 90.w,
              color: colors.greyBackgrondHome_darkPrimary,
              borderRadius: 10,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                MyImageAsset.photoImage,
                height: 70.h,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 260.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomTitleText(
                    text: projectName,
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: colors.titleText,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                ),
              ),
              IconTitleInfoRow(
                icon: Icons.timer_outlined,
                title: "تاريخ انشاء الاستمارة :  ",
                info: historyOfCreate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(numOfAssign<= 5)
                   IconTitleInfoRow(
                    icon: Icons.people_outlined,
                    title: "التوقيعات  :  ",
                    info: "5/$numOfAssign",
                    width: 180,
                  ),
                  if(numOfAssign> 5)
                  IconTitleInfoRow(
                    icon: Icons.people_outlined,
                    title: "التوقيعات  :  ",
                    info: "6/$numOfAssign",
                    width: 180,
                  ),
                  TextIconChip(
                    onTap: onTap,
                    backgroundHeight: 26.h,
                    backgroundWidth: 75.w,
                    icon: Icons.file_download_outlined,
                    text: "تنزيل",
                    textIconColor: AppColors.greyHintLight,
                    // backgroundColor: colors.greyBackgrondHome_darkPrimary, // اختياري
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
