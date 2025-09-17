import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/invitation_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/home/invitations/invitation_model.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<InvitationCintrollerImp>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios,
                        color: colors.titleText, size: 30.h),
                  ),
                  const Spacer(),
                  CustomTitleText(
                    text: "دعوات الانضمام",
                    isTitle: true,
                    screenHeight: 600.sp,
                    textColor: colors.titleText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Divider(color: colors.greyInput_greyInputDark, thickness: 2),
              SizedBox(height: 10.h),
              Expanded(
                child: GetBuilder<InvitationCintrollerImp>(
                  id: "invites",
                  init: controller,
                  builder: (c) {
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (c.statusRequest != StatusRequest.success) {
                      return const Center(
                          child: Text("حدث خطأ أثناء جلب الدعوات"));
                    }
                    if (c.invitationList.isEmpty) {
                      return Center(
                        child: CustomTitleText(
                          text: "لا توجد دعوات لقبولها او رفضها.",
                          isTitle: true,
                          screenHeight: 400.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => c.getListOfInvitations(silent: true),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        itemCount: c.invitationList.length,
                        separatorBuilder: (_, __) => Divider(
                          color: colors.greyInput_greyInputDark,
                          thickness: 1,
                          endIndent: 40.w,
                          indent: 40.w,
                        ),
                        itemBuilder: (context, index) {
                          final inv = c.invitationList[index];
                          return InvitationTile(
                            invitation: inv,
                            colors: colors,
                            onAccept:
                                (inv.status ?? '').toLowerCase() == 'pending'
                                    ? () => c.acceptInvitation(inv.id ?? 0)
                                    : null,
                            onReject:
                                (inv.status ?? '').toLowerCase() == 'pending'
                                    ? () => c.rejectInvitation(inv.id ?? 0)
                                    : null,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvitationTile extends StatelessWidget {
  final Invitations invitation;
  final CustomAppColors colors;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const InvitationTile({
    super.key,
    required this.invitation,
    required this.colors,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final g = invitation.group;
    final statusText = (invitation.status ?? 'pending').toLowerCase();
    final isPending = statusText == 'pending';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   padding: EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: AppColors.greyHintDark),
              //       borderRadius: BorderRadius.circular(20)),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(14.r),
              //     child: SizedBox(
              //       height: 60.h,
              //       width: 60.w,
              //       child: _buildGroupImage(g?.image),
              //     ),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyHintDark),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.asset(g?.image ?? "",
                    height: 60.h,
                    errorBuilder: (_, __, ___) => SvgPicture.asset(
                        MyImageAsset.groupNoPic,
                        height: 50.h,
                        width: 50.h,
                        fit: BoxFit.cover)),
              ),

              SizedBox(width: 12.w),

              // الاسم + التخصصات
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // اسم المجموعة
                    SizedBox(
                      width: double.infinity,
                      child: CustomTitleText(
                        text: g?.name ?? "مجموعة",
                        isTitle: true,
                        screenHeight: 560.sp,
                        textColor: colors.titleText,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // التخصصات المطلوبة (chips)
                    if ((g?.specialityNeeded ?? []).isNotEmpty)
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: (g!.specialityNeeded!)
                            .map((s) => _chip(s))
                            .toList(),
                      ),
                  ],
                ),
              ),

              // حالة الدعوة
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: statusBadge(statusText),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // الأزرار (تعطيل لو ليست pending)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Opacity(
                opacity: isPending ? 1 : .5,
                child: InkWell(
                  onTap: isPending ? onReject : null,
                  child: CustomBackgroundWithWidget(
                    height: 32.h,
                    width: 150.w,
                    color: colors.greyBackgrondHome_darkPrimary,
                    borderRadius: 10,
                    alignment: Alignment.center,
                    child: CustomTitleText(
                      text: "رفض الدعوة",
                      isTitle: true,
                      maxLines: 1,
                      screenHeight: 350.sp,
                      textAlign: TextAlign.center,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.white
                          : AppColors.greyHintDark,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Opacity(
                opacity: isPending ? 1 : .5,
                child: InkWell(
                  onTap: isPending ? onAccept : null,
                  child: CustomBackgroundWithWidget(
                    height: 32.h,
                    width: 150.w,
                    color: colors.primary_cyen,
                    borderRadius: 10,
                    alignment: Alignment.center,
                    child: CustomTitleText(
                      text: "قبول الدعوة",
                      isTitle: true,
                      maxLines: 1,
                      screenHeight: 350.sp,
                      textAlign: TextAlign.center,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.cyenToWhite_greyInputDark,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "# $text",
        style: TextStyle(
          color: colors.primary_cyen,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget statusBadge(String status) {
    Color bg;
    Color fg;

    switch (status) {
      case 'accepted':
        bg = const Color(0xFFE8F5E9);
        fg = const Color(0xFF2E7D32);
        break;
      case 'rejected':
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFC62828);
        break;
      default:
        bg = const Color(0xFFFFF8E1);
        fg = const Color(0xFFEF6C00);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Get.find<ThemeController>().isDark
            ? colors.greyBackgrondHome_darkPrimary
            : bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status == 'pending' ? 'بانتظارك' : status,
        style:
            TextStyle(fontSize: 12.sp, color: fg, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildGroupImage(dynamic raw) {
    final placeholderIsSvg =
        MyImageAsset.groupPic.toLowerCase().endsWith('.svg');
    final placeholder = placeholderIsSvg
        ? SvgPicture.asset(MyImageAsset.groupPic, fit: BoxFit.cover)
        : Image.asset(MyImageAsset.groupPic, fit: BoxFit.cover);

    final path = (raw is String) ? raw.trim() : '';
    if (path.isEmpty) return placeholder;

    final lower = path.toLowerCase();
    final isUrl = lower.startsWith('http://') || lower.startsWith('https://');
    final isSvg = lower.endsWith('.svg');

    if (isUrl) {
      return isSvg
          ? SvgPicture.network(path,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => SvgPicture.asset(
                  MyImageAsset.groupNoPic,
                  height: 120.h,
                  width: 120.h,
                  fit: BoxFit.cover))
          : Image.network(path,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => SvgPicture.asset(
                  MyImageAsset.groupNoPic,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover));
    } else {
      return isSvg
          ? SvgPicture.asset(path,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => SvgPicture.asset(
                  MyImageAsset.groupNoPic,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover))
          : Image.asset(path,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => SvgPicture.asset(
                  MyImageAsset.groupNoPic,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover));
    }
  }
}
