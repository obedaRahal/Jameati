import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';


void showCustomSnackbar({
  required String title,
  required String message,
  required bool isSuccess,
  bool acceptClick = false,
  VoidCallback? onTap,
}) {
  final BuildContext? context = Get.context;

  if (context == null) {
    debugPrint("❌ context is null - cannot show snackbar.");
    return;
  }

  final Color mainColor = isSuccess ? const Color(0xff00CC14) : const Color(0xffFF4747);
  final IconData iconData = isSuccess ? Icons.check : Icons.close;

  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(0),
    margin:  EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.w),
    borderRadius: 50,
    duration: const Duration(seconds: 3),

    // ✅ التعامل مع النقر إذا تم تفعيله
    onTap: acceptClick && onTap != null ? (_) => onTap() : null,

    messageText: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTitleText(
                    isTitle: true,
                    screenHeight: 500.sp,
                    text: title,
                    textAlign: TextAlign.right,
                    textColor: Colors.white,
                    maxLines: 3,
                  ),
                  CustomTitleText(
                    isTitle: false,
                    screenHeight: 700.sp,
                    text: message,
                    textAlign: TextAlign.right,
                    textColor: Colors.white,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(height: 4.h),
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  iconData,
                  color: mainColor,
                  size: 40.h,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
