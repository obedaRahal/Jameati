import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/bottom%20sheet/show_member_bottom_sheet.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/main_info_row.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/member_at_my_group_item.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/team_leader_widget.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class GeneralInfoScreenPart extends StatelessWidget {
  const GeneralInfoScreenPart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return GetBuilder<MyGroupControllerImp>(
      builder: (controller) {
        // حالات التحميل/الفشل
        if (controller.statusRequest == StatusRequest.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.statusRequest != StatusRequest.success) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTitleText(
                  text: "تعذّر جلب معلومات المجموعة",
                  isTitle: true,
                  screenHeight: 600.sp,
                  textColor: colors.titleText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: controller.getPublicDeatilsOfMyGroup,
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        }

        final d = controller.myGroupPublicDeatilsModel?.details;
        if (d == null) return const SizedBox.shrink();

        // القائد الحالي (إن وجد)
        final leader = (d.members ?? []).where((m) => m.isLeader == true).toList();
        final leaderItem = leader.isNotEmpty ? leader.first : null;

        // باقي الأعضاء (بدون القائد)
        final members = (d.members ?? []).where((m) => m.isLeader != true).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTitleText(
              text: "رئيسية",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            // معلومات عامة
            MainInfoRow(
              numOfStudent: "${d.membersCount ?? 0}",
              idea: d.ideaArabicName ?? "—",
              historyOfCreate: d.groupCreatedAt ?? "—",
              nameOfDoctor: (d.supervisorName?.toString().isNotEmpty ?? false)
                  ? d.supervisorName.toString()
                  : "—",
            ),

            SizedBox(height: 16.h),

            // مشرف (القائد)
            CustomTitleText(
              text: "مشرف الغروب",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            if (leaderItem != null)
              TeamLeaderWidget(
                name: leaderItem.name ?? "—",
                stausStudents: leaderItem.studentStatus ?? "—",
                spicialisation: [
                  if ((leaderItem.speciality ?? "").isNotEmpty)
                    leaderItem.speciality!
                  else
                    "—"
                ],
                onTap: () {
                  // مثال فتح شيت تغيير القائد
                  controller.getListOfMemberToTeamLeader();
                  showMemberAtMyGroupToChangeLeaderHeaderSheet(
                    title: "أعضاء المجموعة",
                    colors: colors,
                    controller: controller,
                    onSelected: (m) {
                      debugPrint('Selected leader: ${m.name} (${m.id}) (${m.userId})');
                      controller.changeLeader(m.userId?? 0);
                    },
                  );
                },
              )
            else
              CustomTitleText(
                text: "لا يوجد مشرف محدّد",
                isTitle: true,
                screenHeight: 500.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.center,
              ),

            SizedBox(height: 16.h),
            Divider(
              color: colors.greyInput_greyInputDark,
              thickness: 2,
              endIndent: 40.w,
              indent: 40.w,
            ),

            // الأعضاء
            CustomTitleText(
              text: "الأعضاء",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            if (members.isEmpty)
              CustomTitleText(
                text: "لا يوجد أعضاء",
                isTitle: true,
                screenHeight: 500.sp,
                textColor: AppColors.greyHintLight,
                textAlign: TextAlign.center,
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: members.length,
                separatorBuilder: (_, __) => Divider(
                  color: colors.greyInput_greyInputDark,
                  thickness: 2,
                  endIndent: 40.w,
                  indent: 40.w,
                ),
                itemBuilder: (_, i) {
                  final m = members[i];
                  return MemberAtMyGroupItem(
                    name: m.name ?? "—",
                    spicialisation: [
                      if ((m.speciality ?? "").isNotEmpty) m.speciality! else "—"
                    ],
                  );
                },
              ),

            SizedBox(height: 16.h),
            Divider(
              color: colors.greyInput_greyInputDark,
              thickness: 2,
              endIndent: 40.w,
              indent: 40.w,
            ),

            // دعوة الأعضاء + QR
            CustomTitleText(
              text: "دعوة الاعضاء",
              isTitle: true,
              screenHeight: 600.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber, color: AppColors.red, size: 30.h),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: CustomTitleText(
                      text:
                          "عند مسح هذا ال QR سيتم ارسال طلب انضمام الى الحساب الذي قام بمسح هذا الرمز بشكل تلقائي حتى لو كانت المجموعة خاصة وليست عامة",
                      isTitle: true,
                      screenHeight: 350.sp,
                      textColor: AppColors.greyHintLight,
                      textAlign: TextAlign.right,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(width: 6.w),

                  // QR من التفاصيل
                  SizedBox(
                    width: 110.h,
                    height: 110.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.greyHintDark, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildQr(d.qrCode),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // ==== Helpers ====

  /// يعرض QR سواء كان URL أو Asset أو Base64 أو SVG
  Widget _buildQr(String? data) {
    if (data == null || data.isEmpty) {
      // fallback صورة افتراضية
      return _fallbackImage();
    }

    final lower = data.toLowerCase();

    // Data URI (base64)
    if (lower.startsWith('data:image/')) {
      try {
        final comma = data.indexOf(',');
        final b64 = comma != -1 ? data.substring(comma + 1) : data;
        final bytes = base64Decode(b64);
        return Image.memory(Uint8List.fromList(bytes), fit: BoxFit.cover);
      } catch (_) {
        return _fallbackImage();
      }
    }

    // URL
    final isHttp = lower.startsWith('http://') || lower.startsWith('https://');
    final isSvg = lower.endsWith('.svg');

    if (isHttp) {
      if (isSvg) {
        return SvgPicture.network(data, fit: BoxFit.cover);
      }
      return Image.network(
        data,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallbackImage(),
      );
    }

    // Asset
    if (isSvg) {
      return SvgPicture.asset(data, fit: BoxFit.cover);
    }
    return Image.asset(
      data,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    final path = MyImageAsset.profileNoPic;
    final isSvg = path.toLowerCase().endsWith('.svg');
    return isSvg
        ? SvgPicture.asset(path, fit: BoxFit.cover)
        : Image.asset(path, fit: BoxFit.cover);
  }
}