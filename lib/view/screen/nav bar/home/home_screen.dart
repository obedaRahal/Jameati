import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/data/datasource/static/static.dart';
import 'package:project_manag_ite/data/model/home/sixth%20person/complete_group_model.dart';
import 'package:project_manag_ite/view/shimmer/home/form_submit_shimmer.dart';
import 'package:project_manag_ite/view/widget/home/best_marks_carosal_slider.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/home/custom_indicator_with_text_row.dart';
import 'package:project_manag_ite/view/widget/home/custom_select_button.dart';
import 'package:project_manag_ite/view/widget/home/form_submit_widget_in_row.dart';
import 'package:project_manag_ite/view/widget/home/image_card_widget_home.dart';
import 'package:project_manag_ite/view/widget/home/new_ads_and_ads_text_row.dart';
import 'package:project_manag_ite/view/widget/home/notificat_name_profile_row.dart';
import 'package:project_manag_ite/view/widget/home/statistic_all_row.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<HomeControllerImp>();

    final List<int> years = [2024, 2023, 2022, 2021];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 18.h,
          left: 18.h,
          right: 18.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              NotificationNameProfileRow(
                colors: colors,
              ),
              SizedBox(
                height: 10.h,
              ),
              // SizedBox(
              //   height: 16.h,
              // ),
              GetBuilder<HomeControllerImp>(builder: (controller) => 
              NewAdsAndAdsTextRow(
                colors: colors,
                text: "قسم الإعلانات",
                title: "اعلان جديد",
                numOfAdv: "${controller.numberOfAdvModel?.total}" ,
              ),),
              SizedBox(
                height: 10.h,
              ),
              GetBuilder<HomeControllerImp>(builder: (controller) => ImageCardWidgetRow(
                numOfImgAdv: controller.numberOfAdvModel?.images.toString() ?? "0",
                numOfPdfAdv: controller.numberOfAdvModel?.files.toString() ?? "0",
                onTapImgAdv: () {
                  debugPrint("img adv");
                  Get.toNamed(AppRoute.advImgScreen);
                },
                onTapPdfAdv: () {
                  debugPrint("pdf adv");
                  Get.toNamed(AppRoute.advPdfScreen);
                },
              ),),
              SizedBox(
                height: 20.h,
              ),
              CustomIndicatorWithTextRow(
                text: "من أجلك",
                pageController: controller.pageController,
                //heightMediaQ: heightMediaQ,
              ),
              // const SizedBox(
              //   height: 10,
              // ),

              GetBuilder<HomeControllerImp>(
                builder: (controller) {
                  if (controller.statusRequest == StatusRequest.loading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        const FormSubmitShimmer(),
                      ],
                    );
                  }

                  return FormSubmitWidgetRowwww(
                    form1DayOrMonth:
                        controller.formDatesModel?.form1?.remainingUnit ?? "--",
                    form1StartDate:
                        controller.formDatesModel?.form1?.start ?? "--\\--\\--",
                    form1EndDate:
                        controller.formDatesModel?.form1?.end ?? "--\\--\\--",
                    form1Remaining:
                        controller.formDatesModel?.form1?.remainingNumber ??
                            "00",
                    form2DayOrMonth:
                        controller.formDatesModel?.form2?.remainingUnit ?? "--",
                    form2StartDate:
                        controller.formDatesModel?.form2?.start ?? "--\\--\\--",
                    form2EndDate:
                        controller.formDatesModel?.form2?.end ?? "--\\--\\--",
                    form2Remaining:
                        controller.formDatesModel?.form2?.remainingNumber ??
                            "00",
                    onTapIdea: () {
                      debugPrint("idea");
                      Get.toNamed(AppRoute.submitIdeaScreen);
                    },
                    onTapForm2: () {
                      debugPrint("form 22222");
                      Get.toNamed(AppRoute.formTowScreen);
                    },
                    onTapSixthPerson: () {
                      debugPrint("six person");
                      sixthPersonSheet(
                          colors: colors,
                          controller: controller,
                          title: "طلب انضمام طالب سادس");
                      controller.getListCompleteGroup();
                    },
                  );
                },
              ),

              // SizedBox(
              //   height: 20.h,
              // ),
              CustomTitleText(
                  text: "احصائيات",
                  isTitle: true,
                  screenHeight: 600.sp,
                  textColor: colors.titleText,
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10.h,
              ),
              GetBuilder<HomeControllerImp>(
                builder: (controller) => StatisticAllRow(
                  numOfDoctor: controller.statisticsModel?.data?.doctorsCount
                          .toString() ??
                      "0",
                  numOfGroups: controller.statisticsModel?.data?.groupsCount
                          .toString() ??
                      "0",
                  numOfStudent: controller.statisticsModel?.data?.studentsCount
                          .toString() ??
                      "0",
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CustomIndicatorWithTextRow(
                  pageCount: staticSliderData.length,
                  text: "الأعلى تقييما",
                  pageController: PageController(
                    initialPage: controller.carouselCurrentIndex.value,
                  ),
                  //heightMediaQ: heightMediaQ,
                  textDirection: TextDirection.rtl,
                ),
              ),
              Obx(() => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          for (final year in years)
                            CustomSelectButton(
                              colors: colors,
                              text: '$year',
                              isSelected: controller.selectedYear.value == year,
                              onTap: () {
                                //controller.selectedYear.value = year;
                                // نفذ هنا منطق التحديث إن وُجد
                                //debugPrint("تم اختيار السنة: $year");
                                controller.getTheTopProjectByYear(year);
                                controller.selectedYear.value =
                                    year; // RxInt للتخزين
                                controller.getTheTopProjectByYear(
                                    year); // التمرير كـ int
                              },
                            ),
                        ],
                      ),
                    ),
                  )),
              BestMarkCarosalSlider(),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCardWidgetRow extends StatelessWidget {
  const ImageCardWidgetRow(
      {super.key, required this.onTapImgAdv, required this.onTapPdfAdv, required this.numOfImgAdv, required this.numOfPdfAdv});

  final Function()? onTapImgAdv;
  final Function()? onTapPdfAdv;
  final String numOfImgAdv ;
  final String numOfPdfAdv ;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTapImgAdv,
          child: ImageCardWidget(
            backgroundColor: Get.find<ThemeController>().isDark
                ? AppColors.darkPrimary
                : AppColors.yellowWhite,
            iconAsset: MyImageAsset.imgIcon,
            numberText: numOfImgAdv,
            backgroundNumberText: Get.find<ThemeController>().isDark
                ? AppColors.yellow
                : AppColors.white,
            titleText: "صور",
            titleTextColor: AppColors.yellow,
            imageAsset: MyImageAsset.photoImage,
            //heightMediaQ: MediaQuery.of(context).size.height,
          ),
        ),
        InkWell(
          onTap: onTapPdfAdv,
          child: ImageCardWidget(
            backgroundColor: colors.cyenToWhite_greyInputDark,
            iconAsset: MyImageAsset.pdfIcon,
            numberText: numOfPdfAdv,
            backgroundNumberText: Get.find<ThemeController>().isDark
                ? AppColors.cyen
                : AppColors.white,
            titleText: "ملفات",
            titleTextColor: AppColors.cyen,
            imageAsset: MyImageAsset.pdfImage,
            //heightMediaQ: MediaQuery.of(context).size.height,
          ),
        )
      ],
    );
  }
}

void sixthPersonSheet({
  required String title,
  required CustomAppColors colors,
  required HomeControllerImp controller,
}) {
  Get.bottomSheet(
    Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 420.h,
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                Container(
                  width: 44.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: colors.cyenToWhite_greyInputDark,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.primary_cyen,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                const Divider(thickness: 1, color: Colors.black12),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTitleText(
                      text: "اختر المجموعة",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: 500.sp,
                      horizontalPadding: 20.h,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Obx(() {
                  final list = controller.fullGroupsList;

                  // لو لسه عم يحمل أو ما في بيانات
                  if (controller.statusRequest == StatusRequest.loading &&
                      list.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (list.isEmpty) {
                    return CustomTitleText(
                      text: "لا توجد مجموعات متاحة",
                      isTitle: true,
                      textColor: AppColors.greyHintLight,
                      screenHeight: 500.sp,
                      textAlign: TextAlign.center,
                    );
                  }

                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField<int>(
                      value: controller
                          .selectedGroupId.value, // ← id الحالي إن وجد
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      hint: CustomTitleText(
                        horizontalPadding: 10,
                        text: controller.selectedGroupName.isNotEmpty
                            ? controller.selectedGroupName.value
                            : "اختر مجموعة",
                        isTitle: true,
                        textColor: AppColors.greyHintLight,
                        screenHeight: 300.sp,
                        textAlign: TextAlign.right,
                      ),
                      dropdownColor: Get.isDarkMode
                          ? const Color(0xFF2C2C2C)
                          : Colors.white,
                      items: list
                          .where((g) => g.id != null) // تأكد من وجود id
                          .map((g) => DropdownMenuItem<int>(
                                value: g.id!,
                                child: Text(g.name ?? 'بدون اسم',
                                    textDirection: TextDirection.rtl),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val == null) return;
                        // استخرج العنصر المختار من اللستة
                        final g = list.firstWhere(
                          (x) => x.id == val,
                          orElse: () => FullGroupsModel(id: val, name: ''),
                        );
                        controller.selectedGroupId.value = val;
                        controller.selectedGroupName.value = g.name ?? '';
                        // لو بدك تعمل أي حدث إضافي بعد الاختيار، ضيفه هون
                        // debugPrint("selected id=${val}, name=${controller.selectedGroupName.value}");
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.greyInput_greyInputDark,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: colors.primary_cyen),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: AppColors.red),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTitleText(
                      text: "وصف الطالب",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: 500.h,
                      horizontalPadding: 20.h,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colors.greyInput_greyInputDark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextFormField(
                    controller: controller.description,
                    maxLines: 4,
                    style: TextStyle(
                      color: colors.titleText,
                      fontFamily: MyFonts.hekaya,
                      fontSize: 15.sp,
                    ),
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText:
                          "ادخل الأسباب التي تتطلب وجود عضو سادس في المجموعة...",
                      hintStyle: TextStyle(
                        color: AppColors.greyHintLight,
                        fontSize: 14.sp,
                        fontFamily: MyFonts.hekaya,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        debugPrint(controller.selectedGroupName.value);
                        debugPrint(controller.selectedGroupId.string);
                        debugPrint(controller.description.text);
                        controller.sendRequestToJoinSithPerson();
                      },
                      child: CustomBackgroundWithWidget(
                        height: 40.h,
                        width: 150.w,
                        color: colors.primary_cyen,
                        borderRadius: 15,
                        alignment: Alignment.center,
                        child: CustomTitleText(
                          horizontalPadding: 5.h,
                          text: "إرسال الطلب",
                          isTitle: true,
                          maxLines: 1,
                          screenHeight: 400.sp,
                          textAlign: TextAlign.center,
                          textColor: AppColors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.2),
    elevation: 0,
  );
}
