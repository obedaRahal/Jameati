import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/show_member_to_change_leader.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

void showMemberAtMyGroupToChangeLeaderHeaderSheet({
  required String title,
  required CustomAppColors colors,
  required MyGroupControllerImp controller,
  void Function(MembersToChangeLeaderModel selected)? onSelected,
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
                  id: "changeLeader",
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
                    final list = c.membersToChangeTeamLeader; // List<Members>
                    if (selectedId.value == null) {
                      final idxLeader =
                          list.indexWhere((m) => m.isLeader == true);
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

class MemberTile extends StatelessWidget {
  final String name;
  final int id;
  final String? avatarPath; // قد تكون null أو URL أو Asset
  final CustomAppColors colors;
  final bool isSelected;
  final VoidCallback onTap;

  const MemberTile({
    super.key,
    required this.name,
    required this.id,
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
            // // الصورة
            // Container(
            //   padding: EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.greyHintDark),
            //       borderRadius: BorderRadius.circular(50)),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(30.r),
            //     child: SizedBox(
            //       height: 50.h,
            //       width: 50.h,
            //       child: _buildAvatar(avatarPath),
            //     ),
            //   ),
            // ),
               Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyHintDark),
                    borderRadius: BorderRadius.circular(40)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(avatarPath ?? "",
                    height: 50.h,
                    errorBuilder: (_, __, ___) => SvgPicture.asset(
                        MyImageAsset.profileNoPic,
                        height: 50.h,
                        width: 50.h,
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(width: 12.w),

            CustomTitleText(
              text: name,
              maxLines: 1,
              isTitle: true,
              screenHeight: 500.sp,
              textAlign: TextAlign.center,
              textColor: colors.titleText,
            ),
            Spacer(),

            // دائرة الاختيار
            _RadioCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String? path) {
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
