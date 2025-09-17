import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/model/form%20one/doctor_for_formone_model.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/bottom%20sheet/show_join_request_bottom_sheet.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/doctor_and_chang_doctor.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/horizonal_avatar_list.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/my_project_and_download_bottun.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/text_icon_chip.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/timer_and_join_reqest_row.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ProjectScreenPart extends StatelessWidget {
  const ProjectScreenPart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final c = Get.find<MyGroupControllerImp>();

    return GetBuilder<MyGroupControllerImp>(
      builder: (_) {
        if (c.statusRequest == StatusRequest.loading &&
            c.infoOfProjectModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final f1 = c.form1; // form1
        final f2 = c.form2; // form2
        final g = c.grades; // grades
        final interview =
            c.infoOfProjectModel?.data?.finalInterview; // interview

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),

            // زر طلبات الانضمام (كما هو)
            TimerAndJoinReqestRow(
              timeOfInterview:
                  "${interview?.startTime ?? "00:00"} | ${interview?.date ?? "--/--/--"} : مقابلة  نهائية",
              //timeOfInterview: interview?.date ?? "--/--/--",
              onTap: () {
                c.getListOfStudentToJoinMyGroup();
                showJoinRequestsHeaderSheet(
                  title: "طلبات الانضمام",
                  colors: colors,
                  controller: c,
                  onAction: (req, accepted) {
                    if (accepted) {
                      c.acceptJoinRequestToMyGroup(req.userId ?? 0);
                    } else {
                      c.rejectJoinRequestToMyGroup(req.userId ?? 0);
                    }
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            // ====== معلومات الاستمارة 1 ======
            CustomTitleText(
              text: "معلومات الاستمارة 1",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // اسم المشرف (معبأ من الـ API)
            if (f1 != null)
              Obx(() => DoctorAndChangeDoctor(
                    doctorName: c.doctorName.value,
                    onTap: () {
                      c.getListOfDoctorToSubmitFormOne();
                      showDoctorToChangeAtMyGroupHeaderSheet(
                        title: "قائمة المشرفين",
                        colors: colors,
                        controller: c,
                        onSelected: (m) {
                          c.doctorName.value = m.name ?? "اسم الدكتور";
                          c.doctorId.value = m.id ?? 0;
                        },
                      );
                    },
                  )),

            SizedBox(
              height: 10.h,
            ),

            // تنزيل الاستمارة 1
            if (f1 == null) ...[
              CustomTitleText(
                text:
                    "لايوجد معلومات عن الاستمارة 1 خاصة بالمجموعة في الوقت الحالي...",
                isTitle: true,
                screenHeight: 400.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.right,
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.primary, width: 3),
                          borderRadius: BorderRadius.circular(6)),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextIconChip(
                          onTap: () {
                            debugPrint("استمارة 1");
                            Get.toNamed(AppRoute.submitIdeaScreen);
                          },
                          backgroundHeight: 40.h,
                          backgroundWidth: 140.w,
                          icon: Icons.format_list_bulleted_add,
                          text: "طلب استمارة 1",
                          textIconColor: AppColors.primary,
                          backgroundColor: colors.cyenToWhite_greyInputDark,
                          borderRadius: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              MyProjectAndDownloadBottun(
                projectName: c.form1?.title ?? "اسم الفكرة",
                historyOfCreate: c.form1?.submissionDate ?? "--/--/--",
                numOfAssign: c.form1?.signaturesCount ?? 0,
                onTap: () {
                  final id = c.form1Id;
                  if (id == null) {
                    showCustomSnackbar(
                        title: "تنزيل",
                        message: "لا يوجد ملف للاستعراض",
                        isSuccess: false);
                    return;
                  }
                  c.downloadFormOne(id);
                },
              ),

              SizedBox(height: 16.h),

              // إجراءات فورم1 (إرسال/توقيع/عرض/تعديل)
              FourActionsToForm1(
                onTapSend: () {
                  debugPrint("send form 11111");
                  c.resendFormOne(c.form1Id ?? 0);
                },
                onTapAssign: () {
                  final id = c.form1Id;
                  if (id == null) {
                    showCustomSnackbar(
                        title: "توقيع",
                        message: "لا يوجد استمارة",
                        isSuccess: false);
                    return;
                  }
                  c.signature(id);
                },
                onTapView: () {
                  // عرض الاستمارة إن أردت
                },
                onTapEdit: () {
                  debugPrint("edit form oneeeeeeeee");
                  editFormOneHeaderSheet(
                      title: "تعديل الاستمارة 1",
                      colors: colors,
                      controller: c);
                },
              ),
            ],

            SizedBox(height: 16.h),
            Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
                endIndent: 40.w,
                indent: 40.w),

            // ====== معلومات الاستمارة 2 ======
            CustomTitleText(
              text: "معلومات الاستمارة 2",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            if (f2 == null) ...[
              CustomTitleText(
                text:
                    "لايوجد معلومات عن الاستمارة 2 خاصة بالمجموعة في الوقت الحالي...",
                isTitle: true,
                screenHeight: 400.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.right,
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.primary, width: 3),
                          borderRadius: BorderRadius.circular(6)),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextIconChip(
                          onTap: () {
                            debugPrint("استمارة 2 create");
                            Get.toNamed(AppRoute.formTowScreen);
                          },
                          backgroundHeight: 40.h,
                          backgroundWidth: 140.w,
                          icon: Icons.format_list_bulleted_add,
                          text: "طلب استمارة 2",
                          textIconColor: AppColors.primary,
                          backgroundColor: colors.cyenToWhite_greyInputDark,
                          borderRadius: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              _infoLine(
                  colors, ": عنوان الاستمارة", c.safe(f2.title ?? ""), 120.w),
              _infoLine(colors, ": تاريخ التقديم",
                  c.safe(f2.submissionDate ?? ""), 100.w),
              //_infoLine(colors, ": الحالة", c.safe(f2.status ?? "")),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextIconChip(
                          onTap: () {
                            debugPrint("download form 2222");
                            c.downloadFormTow(f2.id ?? 0);
                          },
                          backgroundHeight: 40.h,
                          backgroundWidth: 140.w,
                          icon: Icons.format_list_bulleted_add,
                          text: "تحميل استمارة 2",
                          textIconColor: AppColors.primary,
                          backgroundColor: colors.cyenToWhite_greyInputDark,
                          borderRadius: 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 10.h),
            Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
                endIndent: 40.w,
                indent: 40.w),

            // ====== درجات المشروع ======
            CustomTitleText(
              text: "درجات المشروع",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            if (g == null)
              CustomTitleText(
                text:
                    "لايوجد معلومات عن درجات المشروع 2 خاصة بالمجموعة في الوقت الحالي...",
                isTitle: true,
                screenHeight: 400.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.right,
                maxLines: 3,
              ),
            if (g != null)
              InterviewCommitteeCard(
                listOfDoctorImage: c.committeeImages,
                totalMark: g?.total ?? 0,
                finalMark: g?.presentationGrade ?? 0, // عدّل وفق تصميمك
                mileStonesMark: g?.projectGrade ?? 0,
                listOfStudentImage:
                    c.membersStudentImages, // صور الطلاب (أو بلايسهولدر)
              ),

            SizedBox(height: 16.h),

            Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
                endIndent: 40.w,
                indent: 40.w),

            // ====== معلومات الاستمارة 2 ======
            CustomTitleText(
              text: "معلومات المقابلة النهائية",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            // (اختياري) مقابلة نهائية
            if (c.infoOfProjectModel?.data?.finalInterview != null) ...[
              const SizedBox(height: 8),
              _infoLine(
                  colors,
                  ": تاريخ المناقشة",
                  c.safe(c.infoOfProjectModel!.data!.finalInterview!.date),
                  110.w),
              _infoLine(
                  colors,
                  ": من",
                  c.safe(c.infoOfProjectModel!.data!.finalInterview!.startTime),
                  50.w),
              _infoLine(
                  colors,
                  ": إلى",
                  c.safe(c.infoOfProjectModel!.data!.finalInterview!.endTime),
                  50.w),
            ] else ...[
              CustomTitleText(
                text:
                    "لايوجد معلومات عن المقابلات الخاصة بالمجموعة في الوقت الحالي...",
                isTitle: true,
                screenHeight: 400.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.right,
                maxLines: 3,
              ),
            ],

            // زر مغادرة المجموعة
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.red, width: 3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextIconChip(
                        onTap: () {
                          if (c.groupId == null) {
                            showCustomSnackbar(
                                title: "خطأ",
                                message: "لم يتم تحديد المجموعة.",
                                isSuccess: false);
                            return;
                          }
                          c.leaveGroup(c.groupId!);
                        },
                        backgroundHeight: 40.h,
                        backgroundWidth: 140.w,
                        icon: Icons.logout,
                        text: "مغادرة الغروب",
                        textIconColor: AppColors.red,
                        backgroundColor: AppColors.redPink,
                        borderRadius: 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // سطر معلومة بسيط
  Widget _infoLine(CustomAppColors colors, String title, String value,
      double backGroundWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTitleText(
              text: value,
              isTitle: true,
              screenHeight: 450.sp,
              textColor: AppColors.greyHintLight,
              textAlign: TextAlign.left,
            ),
          ),
          CustomBackgroundWithWidget(

            height: 30,
            width: backGroundWidth,
            color: colors.cyenToWhite_greyInputDark,
            borderRadius: 10,
            alignment: Alignment.centerRight,
            child: CustomTitleText(
              horizontalPadding: 5.w,
              text: title,
              isTitle: true,
              screenHeight: 380.sp,
              textColor: colors.primary_cyen,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}

void showDoctorToChangeAtMyGroupHeaderSheet({
  required String title,
  required CustomAppColors colors,
  required MyGroupControllerImp controller,
  void Function(DoctorData selected)? onSelected,
}) {
  final Rx<int?> selectedId = Rx<int?>(null); // يملأ لاحقًا بعد نجاح الجلب
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
                child: GetBuilder<MyGroupControllerImp>(
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
                        return Obx(() => DoctorTile(
                              name: m.name ?? '',
                              id: m.id ?? -1,
                              numOfDocs: m.pending_forms_count ?? 0,
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

class DoctorTile extends StatelessWidget {
  final String name;
  final int id;
  final int numOfDocs;
  final String? avatarPath; // قد تكون null أو URL أو Asset
  final CustomAppColors colors;
  final bool isSelected;
  final VoidCallback onTap;

  const DoctorTile({
    super.key,
    required this.name,
    required this.id,
    required this.numOfDocs,
    required this.avatarPath,
    required this.colors,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // الصورة

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyHintDark),
                  borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: SizedBox(
                  height: 50.h,
                  width: 50.h,
                  child: _buildAvatar(avatarPath),
                ),
              ),
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30.r),
            //   child: SizedBox(
            //     height: 70.h,
            //     width: 65.w,
            //     child: _buildAvatar(avatarPath),
            //   ),
            // ),
            SizedBox(width: 12.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitleText(
                  text: name,
                  maxLines: 1,
                  isTitle: true,
                  screenHeight: 500.sp,
                  textAlign: TextAlign.center,
                  textColor: colors.titleText,
                ),
                CustomBackgroundWithWidget(
                  height: 25.h,
                  width: 200.w,
                  color: colors.cyenToWhite_greyInputDark,
                  borderRadius: 10,
                  child: CustomTitleText(
                    text: "لدى الدكتور $numOfDocs استمارات بالانتظار",
                    maxLines: 1,
                    isTitle: true,
                    screenHeight: 300.sp,
                    textAlign: TextAlign.center,
                    textColor: colors.primary_cyen,
                  ),
                )
              ],
            ),
            const Spacer(),

            // دائرة الاختيار
            _RadioCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }

  _buildAvatar(String? path) {
    final fallback = (MyImageAsset.profileNoPic.toLowerCase().endsWith('.svg'))
        ? SvgPicture.asset(MyImageAsset.profileNoPic, fit: BoxFit.cover)
        : Image.asset(MyImageAsset.profileNoPic, fit: BoxFit.cover);

    if (path == null || path.isEmpty) return fallback;

    final lower = path.toLowerCase();
    final isUrl = lower.startsWith('http://') || lower.startsWith('https://');
    final isSvg = lower.endsWith('.svg');

    if (isUrl) {
      if (isSvg) return SvgPicture.network(path, fit: BoxFit.cover);
      return Image.network(path, fit: BoxFit.cover);
    } else {
      if (isSvg) return SvgPicture.asset(path, fit: BoxFit.cover);
      return (MyImageAsset.groupPic.toLowerCase().endsWith('.svg'))
          ? SvgPicture.asset(MyImageAsset.groupPic, fit: BoxFit.cover)
          : Image.asset(MyImageAsset.groupPic, fit: BoxFit.cover);
    }
  }
}

class _RadioCircle extends StatelessWidget {
  final bool isSelected;
  const _RadioCircle({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? (colors.primary_cyen) : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.primary : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}

class FourActionsToForm1 extends StatelessWidget {
  const FourActionsToForm1(
      {super.key,
      required this.onTapSend,
      required this.onTapAssign,
      required this.onTapView,
      required this.onTapEdit});

  final dynamic Function()? onTapSend;
  final dynamic Function()? onTapAssign;
  final dynamic Function()? onTapView;
  final dynamic Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // إرسال الاستمارة (أخضر)
            TextIconChip(
                onTap: onTapSend,
                backgroundHeight: 30.h,
                backgroundWidth: 130.w,
                icon: Icons.check_circle_outline,
                text: "إرسال الاستمارة",
                textIconColor: Colors.white,
                backgroundColor: AppColors.green),

            //SizedBox(width: 10.w),

            // توقيع (أصفر)
            TextIconChip(
                onTap: onTapAssign,
                backgroundHeight: 30.h,
                backgroundWidth: 75.w,
                icon: Icons.gesture, // أيقونة أقرب للتوقيع
                text: "توقيع",
                textIconColor: Colors.white,
                backgroundColor: AppColors.yellow),

            //SizedBox(width: 10.w),

            // تعديل الاستمارة (أحمر)
            TextIconChip(
                onTap: onTapEdit,
                backgroundHeight: 30.h,
                backgroundWidth: 120.w,
                icon: Icons.edit_outlined,
                text: "تعديل الاستمارة",
                textIconColor: Colors.white,
                backgroundColor: AppColors.red),
          ],
        ),
      ),
    );
  }
}

class InterviewCommitteeCard extends StatelessWidget {
  final List<String> listOfDoctorImage;
  final int totalMark;
  final int finalMark;
  final int mileStonesMark;
  final List<String> listOfStudentImage;

  const InterviewCommitteeCard({
    Key? key,
    required this.listOfDoctorImage,
    required this.totalMark,
    required this.finalMark,
    required this.mileStonesMark,
    required this.listOfStudentImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBackgrondHome, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 120.w,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CustomTitleText(
                      text: "لجنة المقابلة :",
                      isTitle: true,
                      screenHeight: 450.sp,
                      textColor: colors.titleText,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                    ),
                  ),
                ),
                HorizontalAvatarList(
                  listAvatar: listOfDoctorImage,
                  borderRadius: 10,
                  width: 110.w,
                ),
              ],
            ),
            SizedBox(
              height: 80.h,
              child: const VerticalDivider(
                color: AppColors.greyHintLight,
                thickness: 1,
                width: 20,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomBackgroundWithWidget(
                    height: 30.h,
                    width: 190.w,
                    color: Get.find<ThemeController>().isDark
                        ? const Color(0xff3F3F3F)
                        : AppColors.greyInput,
                    borderRadius: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBackgroundWithWidget(
                          height: 45.h,
                          width: 55.w,
                          color: colors.primary_cyen,
                          borderRadius: 20,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  totalMark.toString(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: MyFonts.hekaya,
                                    color: colors.backgroundWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  height: 15.w,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color: colors.backgroundWhite,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: AppColors.primary,
                                    size: 15.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "مرحلي : $mileStonesMark / نهائي : $finalMark",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: MyFonts.hekaya,
                                  color: AppColors.greyHintDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                HorizontalAvatarList(
                  listAvatar: listOfStudentImage,
                  borderRadius: 20,
                  width: 190.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void editFormOneHeaderSheet({
  required String title,
  required CustomAppColors colors,
  required MyGroupControllerImp controller,
}) {
  controller.initForm1EditingFields();
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
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Obx(() => DoctorAndChangeDoctor(
                          doctorName: controller.doctorName.value,
                          onTap: () {
                            controller.getListOfDoctorToSubmitFormOne();
                            showDoctorToChangeAtMyGroupHeaderSheet(
                              title: "قائمة المشرفين",
                              colors: colors,
                              controller: controller,
                              onSelected: (m) {
                                controller.doctorName.value =
                                    m.name ?? "اسم الدكتور";
                                controller.doctorId.value = m.id ?? 0;
                              },
                            );
                          },
                        )),
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
                        validator: (val) => null,
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
                        validator: (val) => null,
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
                      screenHeight: 300.sp,
                      horizontalPadding: 20.h,
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
                        validator: (val) => null,
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
                            validator: (val) => null,
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
                            validator: (val) => null,
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
                        validator: (val) => null,
                        label: "أصحاب المصلحة",
                        hint: "اذكر اصحاب المصلحة المستفيدين من المشروع...",
                        icon: Icons.people_outline_outlined,
                        myController: controller.stackholder,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            //controller.creteFormOne();
                            debugPrint(
                                "${controller.doctorId} and his name is ${controller.doctorName.value}");
                            controller.updateFormOne();
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
                    SizedBox(
                      height: 16.h,
                    )
                  ],
                ),
              )),
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
