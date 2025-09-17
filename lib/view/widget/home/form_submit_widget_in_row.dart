import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/form_submit_widget.dart';

class FormSubmitWidgetRowwww extends StatelessWidget {
  const FormSubmitWidgetRowwww({
    super.key,
    required this.form1StartDate,
    required this.form1EndDate,
    required this.form1Remaining,
    required this.form1DayOrMonth,
    required this.form2StartDate,
    required this.form2EndDate,
    required this.form2Remaining,
    required this.form2DayOrMonth,
    required this.onTapIdea,
    required this.onTapForm2,
    required this.onTapSixthPerson,
  });
  final String form1StartDate;
  final String form1EndDate;
  final String form1Remaining;
  final String form1DayOrMonth;

  final String form2StartDate;
  final String form2EndDate;
  final String form2Remaining;

  final String form2DayOrMonth;

  final Function()? onTapIdea;
  final Function()? onTapForm2;
  final Function()? onTapSixthPerson;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeControllerImp>();
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            height: 120.h,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: PageView(
                controller: controller.pageController,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                    onTap: onTapSixthPerson,
                    child: FormSubmitWidget(
                      //heightMediaQ: MediaQuery.of(context).size.height,
                      imageAsset: MyImageAsset.sixthPerson,
                      titleText: "طلب انضمام عضو",
                      dayCount: form1Remaining,
                      dayOrMonth: form1DayOrMonth,
                      startDate: form1StartDate,
                      endDate: form1EndDate,
                    ),
                  ),
                  InkWell(
                    onTap: onTapForm2,
                    child: FormSubmitWidget(
                      //heightMediaQ: MediaQuery.of(context).size.height,
                      imageAsset: MyImageAsset.form2,
                      titleText: "تقديم استمارة 2",
                      dayCount: form2Remaining,
                      dayOrMonth: form2DayOrMonth,
                      startDate: form2StartDate,
                      endDate: form2EndDate,
                    ),
                  ),
                  InkWell(
                    onTap: onTapIdea,
                    child: FormSubmitWidget(
                      //heightMediaQ: MediaQuery.of(context).size.height,
                      imageAsset: MyImageAsset.lampOutLine,
                      titleText: "تقديم فكرة مشروع",
                      dayCount: form1Remaining,
                      dayOrMonth: form1DayOrMonth,
                      startDate: form1StartDate,
                      endDate: form1EndDate,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
