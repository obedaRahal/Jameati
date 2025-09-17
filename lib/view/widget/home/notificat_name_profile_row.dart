import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class NotificationNameProfileRow extends StatelessWidget {
  const NotificationNameProfileRow({super.key, required this.colors});
  final CustomAppColors colors;

  @override
  Widget build(BuildContext context) {
    final myServices = Get.find<MyServices>();

    final String name = myServices.sharedPreferences.getString("name") ?? "اسم";
    final String profileImage =
        myServices.sharedPreferences.getString("profile_image") ?? "";

    final controller = Get.find<HomeControllerImp>();

    return Row(
      children: [
        InkWell(
          onTap: () {
            debugPrint("notification");
            showNotificationsSheet(
                title: "الإشعارات", colors: colors, controller: controller);
          },
          child: Obx(() => Stack(
                children: [
                  CustomBackgroundWithWidget(
                    height: 50.h,
                    width: 50.h,
                    color: colors.greyBackgrondHome_darkPrimary,
                    borderRadius: 45,
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 35.h,
                      color: AppColors.greyHintLight,
                    ),
                  ),
                  if (controller.notificationCount.value != 0)
                    Positioned(
                      right: 0,
                      child: CustomBackgroundWithWidget(
                        height: 20.h,
                        width: 20.h,
                        color: AppColors.red,
                        borderRadius: 30,
                        child: CustomTitleText(
                          text: "${controller.notificationCount.value}",
                          isTitle: true,
                          screenHeight: 280.sp,
                          textColor: Get.find<ThemeController>().isDark
                              ? AppColors.black
                              : AppColors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            debugPrint("invitationn");
            Get.toNamed(AppRoute.invitationScreen);
          },
          child: CustomBackgroundWithWidget(
              height: 50.h,
              width: 50.h,
              color: colors.greyBackgrondHome_darkPrimary,
              borderRadius: 45,
              child: const FaIcon(
                FontAwesomeIcons.envelopeOpen,
                color: AppColors.greyHintDark,
              )),
        ),
        const Spacer(),
        CustomBackgroundWithWidget(
            height: 45.h,
            width: 190.w,
            color: colors.greyBackgrondHome_darkPrimary,
            borderRadius: 45,
            alignment: Alignment.centerRight,
            child: CustomTitleText(
              horizontalPadding: 15.h,
              text: " $name",
              isTitle: true,
              maxLines: 1,
              screenHeight: 400.sp,
              textAlign: TextAlign.center,
              textColor: AppColors.greyHintLight,
            )),
        SizedBox(width: 4.h),
        InkWell(
          onTap: () {
            debugPrint("profileeeeeee");
            Get.toNamed(AppRoute.profileScreen);
          },
          child: CustomBackgroundWithWidget(
            height: 50.h,
            width: 50.h,
            color: colors.greyBackgrondHome_darkPrimary,
            borderRadius: 45,
            child: profileImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.network(
                      profileImage,
                      fit: BoxFit.cover,
                      width: 50.h,
                      height: 50.h,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.group,
                        size: 25.h,
                        color: AppColors.greyHintDark,
                      ),
                    ),
                  )
                : Icon(
                    Icons.group,
                    size: 25.h,
                    color: AppColors.greyHintDark,
                  ),
          ),
        ),
      ],
    );
  }
}

void showNotificationsSheet({
  required String title,
  required CustomAppColors colors,
  required HomeControllerImp controller,
}) {
  // جلب الإشعارات عند فتح الشيت (إن لم تكن محمّلة)
  if (controller.notificationList.isEmpty) {
    controller.getListOfNotification();
  }

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

              // الجسم
              Expanded(
                child: GetBuilder<HomeControllerImp>(
                  init: controller,
                  builder: (c) {
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (c.statusRequest != StatusRequest.success) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("حدث خطأ أثناء جلب الإشعارات"),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: c.getListOfNotification,
                              child: const Text("إعادة المحاولة"),
                            ),
                          ],
                        ),
                      );
                    }

                    final list = c.notificationList;
                    if (list.isEmpty) {
                      return const Center(child: Text("لا توجد إشعارات"));
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
                        final n = list[index];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // أيقونة
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.white10
                                    : const Color(0xFFF5F8FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.notifications_none),
                            ),
                            SizedBox(width: 12.w),

                            // نصوص الإشعار
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // العنوان
                                  Text(
                                    n.title ?? "بدون عنوان",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),

                                  // المحتوى
                                  Text(
                                    n.body ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),

                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 14),
                                      SizedBox(width: 6.w),
                                      Text(
                                        n.date ?? "",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
