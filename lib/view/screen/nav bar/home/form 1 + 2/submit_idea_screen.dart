import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/form%201%20+%202/submit_idea_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/data/model/form%20one/doctor_for_formone_model.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/bottom%20sheet/show_member_bottom_sheet.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

import '../../../../widget/group/my group/doctor_and_chang_doctor.dart';

class SubmitIdeaScreen extends StatelessWidget {
  const SubmitIdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<SubmitIdeaControllerImp>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTitleText(
                      text: "تقديم فكرة مشروع",
                      isTitle: true,
                      screenHeight: 600.sp,
                      textColor: colors.titleText,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_forward_ios,
                          color: colors.titleText, size: 30.h),
                    ),
                  ],
                ),
                Divider(
                  color: colors.greyInput_greyInputDark,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomBackgroundWithWidget(
                  height: 35.h,
                  width: 100.w,
                  color: colors.primary_cyen,
                  borderRadius: 10,
                  child: CustomTitleText(
                    text: "المشرف",
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: colors.cyenToWhite_greyInputDark,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () => DoctorAndChangeDoctor(
                    doctorName: controller.doctorName.value,
                    onTap: () {
                      debugPrint("change doctor");
                      controller.getListOfDoctorToSubmitFormOne();
                      debugPrint("change doctor");
                      showDoctorAtMyGroupToSelectHimFormOneHeaderSheet(
                        title: "قائمة المشرفين",
                        colors: colors,
                        controller: controller,
                        onSelected: (m) {
                          debugPrint(
                              'Selected new doctor: ${m.name} (${m.id})');
                          //controller.changeLeader(m.userId?? 0);
                          controller.doctorName.value = m.name ?? "اسم الدكتور";
                          controller.doctorId.value = m.id ?? 0;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomBackgroundWithWidget(
                  height: 35.h,
                  width: 100.w,
                  color: colors.primary_cyen,
                  borderRadius: 10,
                  child: CustomTitleText(
                    text: "أساسي",
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: colors.cyenToWhite_greyInputDark,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {},
                    label: "اسم الفكرة باللغة العربية",
                    hint: "ادخل اسم الفكرة الخاصة بك باللغة العربية...",
                    icon: Icons.abc,
                    myController: controller.ideaNameArabic,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {},
                    label: "اسم الفكرة باللغة الانجليزية",
                    hint: "ادخل اسم الفكرة الخاصة بك باللغة الانجليزية...",
                    icon: Icons.abc,
                    myController: controller.ideaNameEnglish,
                  ),
                ),
                CustomTitleText(
                  text: "وصف الفكرة",
                  isTitle: true,
                  textAlign: TextAlign.right,
                  textColor: colors.titleText,
                  screenHeight: MediaQuery.of(context).size.height * .65,
                  horizontalPadding: MediaQuery.of(context).size.height * .025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colors.greyInput_greyInputDark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextFormField(
                    controller: controller.ideaDesc,
                    maxLines: 4,
                    style: TextStyle(
                      color: colors.titleText,
                      fontFamily: MyFonts.hekaya,
                      fontSize: 15.sp,
                    ),
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "ادخل وصف المجموعة الخاصة بك...",
                      hintStyle: TextStyle(
                        color: AppColors.greyHintLight,
                        fontSize: 14.sp,
                        fontFamily: MyFonts.hekaya,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {},
                    label: "نطاق المشروع",
                    hint: "يشمل شرح المشكلة والهدف",
                    icon: Icons.flag_circle_outlined,
                    myController: controller.projectScope,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: FormFieldLabelAndInput(
                        isNumber: false,
                        validator: (val) {},
                        label: "تصنيف      القطاع",
                        hint: "ادخل تصنيف القطاع",
                        icon: Icons.class_outlined,
                        myController: controller.sectorCalssificat,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 170.w,
                      child: FormFieldLabelAndInput(
                        isNumber: false,
                        validator: (val) {},
                        label: "القطاع المستهدف",
                        hint: "ادخل اسم القطاع المستهدف",
                        icon: Icons.sensor_occupied_rounded,
                        myController: controller.targetSector,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {},
                    label: "أصحاب المصلحة",
                    hint: "اذكر اصحاب المصلحة المستفيدين من المشروع...",
                    icon: Icons.people_outline_outlined,
                    myController: controller.stackholder,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomBackgroundWithWidget(
                  height: 35.h,
                  width: 100.w,
                  color: colors.primary_cyen,
                  borderRadius: 10,
                  child: CustomTitleText(
                    text: "الأعضاء",
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: colors.cyenToWhite_greyInputDark,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const StudentHeader(),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        controller.creteFormOne();
                      },
                      child: CustomBackgroundWithWidget(
                        height: 40.h,
                        width: 150.w,
                        color: colors.primary_cyen,
                        borderRadius: 15,
                        alignment: Alignment.center,
                        child: CustomTitleText(
                          horizontalPadding: 5.h,
                          text: "إرسال الفكرة",
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
      )),
    );
  }
}

void showDoctorAtMyGroupToSelectHimFormOneHeaderSheet({
  required String title,
  required CustomAppColors colors,
  required SubmitIdeaControllerImp controller,
  void Function(DoctorData selected)? onSelected,
}) {
  final Rx<int?> selectedId = Rx<int?>(null); 

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
          child: Column(
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F5FF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF22A7F0)),
                ),
              ),
              SizedBox(height: 12.h),
              const Divider(thickness: 1, color: Colors.black12),
              Expanded(
                child: GetBuilder<SubmitIdeaControllerImp>(
                  init: controller,
                  builder: (c) {
                    // Loading
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // Failure
                    if (c.statusRequest != StatusRequest.success) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("حدث خطأ أثناء جلب الأعضاء"),
                            SizedBox(height: 8.h),
                            // ElevatedButton(
                            //   onPressed: c.getListOfMemberToTeamLeader,
                            //   child: const Text("إعادة المحاولة"),
                            // )
                          ],
                        ),
                      );
                    }
                    // Success: أعضاء
                    final list = c.doctorForFormOneList; // List<Members>
                    if (selectedId.value == null) {
                      final idxLeader = list
                          .indexWhere((m) => m.isSupervisorOfAnyForm == true);
                      selectedId.value =
                          idxLeader != -1 ? list[idxLeader].id : null;
                    }
                    if (list.isEmpty) {
                      return const Center(child: Text("لا يوجد أعضاء"));
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => Divider(
                        color: colors.greyInput_greyInputDark,
                        thickness: 1,
                        endIndent: 40.w,
                        indent: 40.w,
                      ),
                      itemBuilder: (context, index) {
                        final m = list[index];
                        return Obx(() => MemberTile(
                              name: m.name ?? '',
                              id: m.id ?? -1,
                              avatarPath: m.profileImage,
                              colors: colors,
                              isSelected: selectedId.value == m.id,
                              onTap: () {
                                if (m.id == null) return;
                                selectedId.value = m.id;
                                if (onSelected != null) onSelected(m);
                              },
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
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

class StudentHeader extends StatelessWidget {
  const StudentHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // عناوين الأعمدة
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTitleText(
                  text: "الحالة",
                  isTitle: true,
                  screenHeight: 450.sp,
                  textColor: AppColors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 70.w),
                CustomTitleText(
                  text: "رقم الهاتف",
                  isTitle: true,
                  screenHeight: 450.sp,
                  textColor: AppColors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 140.w),
                CustomTitleText(
                  text: "الاسم",
                  isTitle: true,
                  screenHeight: 450.sp,
                  textColor: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // 👇 عرض القائمة ديناميكياً
            GetBuilder<SubmitIdeaControllerImp>(
              builder: (c) {
                // حالة التحميل
                if (c.statusRequest == StatusRequest.loading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                // حالة الفشل
                if (c.statusRequest == StatusRequest.failure ||
                    c.statusRequest == StatusRequest.serverfaliure) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      "تعذّر جلب الأعضاء. حاول لاحقًا.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.red),
                    ),
                  );
                }

                // حالة لا بيانات
                if (c.membersAtMyGroupList.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      "لا يوجد أعضاء في مجموعتك",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                }

                // عرض البيانات
                return Column(
                  children: List.generate(c.membersAtMyGroupList.length, (i) {
                    final m = c.membersAtMyGroupList[i];
                    return StudentInlineRow(
                      index: i + 1,
                      name: m.name ?? "-",
                      status: m.studentStatus ?? "-",
                      phoneNumber: m.phoneNumber ?? "-",
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StudentInlineRow extends StatelessWidget {
  final int index;
  final String name;
  final String status;
  final String phoneNumber;

  const StudentInlineRow({
    super.key,
    required this.index,
    required this.name,
    required this.status,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final isDark = Get.find<ThemeController>().isDark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // حالة الطالب
          CustomTitleText(
            text: status,
            isTitle: true,
            horizontalPadding: 6.h,
            screenHeight: 450.sp,
            textColor: colors.primary_cyen,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),

          SizedBox(width: 5.w),

          // رقم الهاتف
          SizedBox(
            width: 140.w,
            height: 47.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyHintDark),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اسم الطالب
                  SizedBox(
                    width: 120.w,
                    child: CustomTitleText(
                      text: phoneNumber,
                      isTitle: true,
                      screenHeight: 450.sp,
                      textColor: AppColors.greyHintDark,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 5.w),

          // الاسم + فقاعة رقم الاندكس
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 3.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyHintDark),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // اسم الطالب
                SizedBox(
                  width: 120.w,
                  child: CustomTitleText(
                    text: name,
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: AppColors.greyHintDark,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 6.w),

                // فقاعة رقم الاندكس
                CustomBackgroundWithWidget(
                  height: 35.w,
                  width: 35.w,
                  color: AppColors.greyHintDark,
                  borderRadius: 30,
                  child: CustomTitleText(
                    text: "$index",
                    isTitle: true,
                    screenHeight: 450.sp,
                    textColor: isDark ? AppColors.black : AppColors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
