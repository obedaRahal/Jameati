import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/show_join_request_model.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

void showJoinRequestsHeaderSheet({
  required String title,
  required CustomAppColors colors,
  required MyGroupControllerImp controller,
  void Function(Requests request, bool accepted)? onAction,
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
              Expanded(
                child: GetBuilder<MyGroupControllerImp>(
                  id: "joinRequests",
                  init: controller,
                  builder: (c) {
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (c.statusRequest != StatusRequest.success) {
                      return const Center(
                          child: Text("حدث خطأ أثناء جلب الطلبات"));
                    }

                    final list = c.requests;
                    if (list.isEmpty) {
                      return const Center(child: Text("لا يوجد طلبات انضمام"));
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
                        final req = list[index];
                        return JoinRequestTile(
                          request: req,
                          colors: colors,
                          onAccept: () => onAction?.call(req, true),
                          onReject: () => onAction?.call(req, false),
                        );
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

class JoinRequestTile extends StatelessWidget {
  final Requests request;
  final CustomAppColors colors;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const JoinRequestTile({
    super.key,
    required this.request,
    required this.colors,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final user = request.user;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // الصورة
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: SizedBox(
                  height: 70.h,
                  width: 65.w,
                  child: _buildAvatar(user?.profileImage),
                ),
              ),
              SizedBox(width: 12.w),

              // الاسم + الاختصاص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomTitleText(
                          text: user?.name ?? "مجهول",
                          isTitle: true,
                          screenHeight: 580.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // إن كان عندك ListSpicializationWidget يدعم String
                    // ListSpicializationWidget(
                    //   spicialisation: user?.studentSpeciality ?? "",
                    //   bgColor: colors.cyenToWhite_greyInputDark,
                    //   textColor: colors.primary_cyen,
                    //   width: 260.w,
                    // ),

                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: CustomBackgroundWithWidget(
                        height: 22.h,
                        width: 90.w,
                        color: colors.cyenToWhite_greyInputDark,
                        borderRadius: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: CustomTitleText(
                            text: "# ${user?.studentSpeciality ?? ""}",
                            isTitle: false,
                            screenHeight: 600.sp,
                            textColor: colors.primary_cyen,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // الحالة
              // CustomBackgroundWithWidget(
              //   height: 20.w,
              //   width: 80.h,
              //   color: colors.cyenToWhite_greyInputDark,
              //   borderRadius: 10,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 8.w),
              //     child: Text(
              //       request.status ?? "بانتظار المراجعة",
              //       style: TextStyle(
              //         fontSize: 14.sp,
              //         color: colors.primary_cyen,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Get.find<ThemeController>().isDark
                      ? colors.greyBackgrondHome_darkPrimary
                      : const Color.fromARGB(255, 255, 236, 207),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  request.status ?? "بانتظار المراجعة",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromARGB(255, 255, 129, 27),
                      fontWeight: FontWeight.w700),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
              //   child: Text(
              //     request.status ?? "بانتظار المراجعة",
              //     style: TextStyle(
              //       fontSize: 14.sp,
              //       color: colors.greyInputDark_greyWithBlack,
              //     ),
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 12.h),

          // أزرار الرفض / القبول
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onReject,
                child: CustomBackgroundWithWidget(
                  height: 32.h,
                  width: 150.w,
                  color: colors.greyBackgrondHome_darkPrimary,
                  borderRadius: 10,
                  alignment: Alignment.center,
                  child: CustomTitleText(
                    text: "رفض طلب انضمام",
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
              InkWell(
                onTap: onAccept,
                child: CustomBackgroundWithWidget(
                  height: 32.h,
                  width: 150.w,
                  color: colors.primary_cyen,
                  borderRadius: 10,
                  alignment: Alignment.center,
                  child: CustomTitleText(
                    text: "تأكيد طلب انضمام",
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
            ],
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? path) {
    // fallback (لو كان groupPic svg)
    final fallbackIsSvg = MyImageAsset.groupPic.toLowerCase().endsWith('.svg');
    final fallback = fallbackIsSvg
        ? SvgPicture.asset(MyImageAsset.groupPic, fit: BoxFit.cover)
        : Image.asset(MyImageAsset.groupPic, fit: BoxFit.cover);

    if (path == null || path.isEmpty) return fallback;

    final lower = path.toLowerCase();
    final isUrl = lower.startsWith('http://') || lower.startsWith('https://');
    final isSvg = lower.endsWith('.svg');

    if (isUrl) {
      return isSvg
          ? SvgPicture.network(path, fit: BoxFit.cover)
          : Image.network(path, fit: BoxFit.cover);
    } else {
      return isSvg
          ? SvgPicture.asset(path, fit: BoxFit.cover)
          : Image.asset(path, fit: BoxFit.cover);
    }
  }
}
