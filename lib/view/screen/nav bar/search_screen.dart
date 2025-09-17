import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/search_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/chats/list%20of%20chats/search_bar_with_clear_widget.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
import 'package:project_manag_ite/view/widget/search/search_history_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<SearchControllerImp>();

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
              CustomTitleText(
                text: "قائمة البحث",
                isTitle: true,
                screenHeight: 800.sp,
                textColor: colors.titleText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.h,
              ),
              SearchBarWithClear(
                actionWidget: CustomTitleText(
                  text: "إلغاء",
                  isTitle: true,
                  screenHeight: 550.sp,
                  textAlign: TextAlign.center,
                  textColor: AppColors.red,
                ),
                hintTextAtSearchBar: "البحث عن اي شيء",
                controller: controller.searchForAnyThing,
                onClear: () {
                  controller.searchForAnyThing.clear();
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
              ),
          
              Obx(() {
                final q = controller.query.value.trim();
          
                if (q.isEmpty) {
                  // ✅ السجل
                  return GetBuilder<SearchControllerImp>(
                    id: controller
                        .historySectionId, // اختياري لو تستخدم GetBuilder
                    builder: (_) => Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTitleText(
                          text: "سجل البحث",
                          isTitle: true,
                          screenHeight: 650.sp,
                          textColor: colors.primary_cyen,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        Obx(() => Wrap(
                              alignment: WrapAlignment.end,
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: controller.searchHistoryList.map((item) {
                                return SearchHistoryItem(
                                  item: item.query ?? "",
                                  onRemove: () =>
                                      controller.deleteSearchItem(item.id ?? 0),
                                );
                              }).toList(),
                            )),
                      ],
                    ),
                  );
                }
          
                // ✅ نتائج البحث من API
                final results = controller.searchReasultList;
                if (results.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 24.h),
                    child: Center(
                      child: Text("لا يوجد نتائج بحث",
                          style: TextStyle(fontSize: 14.sp)),
                    ),
                  );
                }
          
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => Divider(
                    color: colors.greyInput_greyInputDark,
                    thickness: 2,
                    endIndent: 40.w,
                    indent: 40.w,
                  ),
                  itemBuilder: (context, i) {
                    final item = results[i];
                    // عدّل الحقول حسب موديل SearchResault
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SvgPicture.asset(
                                MyImageAsset
                                    .groupPic, // أو NetworkImage من item لو متاح
                                height: 60.h,
                                width: 60.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTitleText(
                                    text: item.name ?? "-", // مثال
                                    isTitle: true,
                                    screenHeight: 580.sp,
                                    textColor: colors.titleText,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                  ),
                                  CustomBackgroundWithWidget(
                                    height: 22.h,
                                    width: 200.w,
                                    color: AppColors.cyenToWhite,
                                    borderRadius: 5,
                                    child: CustomTitleText(
                                      horizontalPadding: 4.h,
                                      text: item.speciality ?? "-", // مثال
                                      isTitle: false,
                                      screenHeight: 600.sp,
                                      textColor: AppColors.primary,
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomTitleText(
                              horizontalPadding: 4.h,
                              text: item.status ?? "-", // مثال
                              isTitle: false,
                              screenHeight: 700.sp,
                              textColor: AppColors.red,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
