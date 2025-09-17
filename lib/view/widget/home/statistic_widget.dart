import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class StatisticWidget extends StatelessWidget {
  final String image;
  final String title;
  final Color titleColor;
  final String number;
  final Color numberColor;
  final Color numberBackgroundColor;

  final int titleMaxLines;
  final int numberMaxLines;
  final double badgeWidth;

  const StatisticWidget({
    super.key,
    required this.title,
    required this.titleColor,
    required this.number,
    required this.numberColor,
    required this.image,
    required this.numberBackgroundColor,
    this.titleMaxLines = 2,
    this.numberMaxLines = 3,
    this.badgeWidth = 90, // أعرض من 45.w ليكفي سطرين
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(image, height: 28.h),
        ),
        CustomTitleText(
          text: title,
          isTitle: true,
          screenHeight: 350.sp,
          textAlign: TextAlign.center,
          textColor: titleColor,
          maxLines: titleMaxLines, // ✅ يدعم سطرين
        ),
        SizedBox(height: 5.h),
        // بدل السكrol: خلّي النص يلف داخل عرض كافي
        CustomBackgroundWithWidget(
          height: numberMaxLines > 1 ? 40.h : 24.h, // ✅ ارتفاع أكبر عند سطرين
          width: numberMaxLines > 1 ? badgeWidth.w : 40.w, // ✅ عرض أوسع
          color: numberBackgroundColor,
          borderRadius: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Center(
              child: CustomTitleText(
                text: number,
                isTitle: true,
                screenHeight: 300.sp,
                textColor: numberColor,
                textAlign: TextAlign.center,
                maxLines: numberMaxLines, // ✅ سطرين
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class StatisticWidget extends StatelessWidget {
//   final String image;
//   final String title;
//   final Color titleColor;
//   final String number;
//   final Color numberColor;
//   final Color numberBackgroundColor;

//   // إعدادات النص
//   final int titleMaxLines;
//   final int numberMaxLines;

//   // إعدادات البادج
//   final double badgeWidth;

//   // ✅ التمرير داخل البادج
//   final bool scrollNumber;          // فعّلها للفكرة فقط
//   final double numberScrollHeight;  // الارتفاع الثابت لمنطقة التمرير

//   const StatisticWidget({
//     super.key,
//     required this.title,
//     required this.titleColor,
//     required this.number,
//     required this.numberColor,
//     required this.image,
//     required this.numberBackgroundColor,
//     this.titleMaxLines = 2,
//     this.numberMaxLines = 2,
//     this.badgeWidth = 90,
//     this.scrollNumber = false,
//     this.numberScrollHeight = 48, // ارتفاع منطقي للتمرير
//   });

//   @override
//   Widget build(BuildContext context) {
//     final badge = Container(
//       width: double.infinity, // خليه يتمدّد داخل Expanded
//       constraints: BoxConstraints(
//         minHeight: 24, // حد أدنى
//         // لو scrollNumber = true بنستخدم SizedBox لاحقًا للتحكم بالارتفاع
//       ),
//       decoration: BoxDecoration(
//         color: numberBackgroundColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//         child: scrollNumber
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: SizedBox(
//                   height: numberScrollHeight.h, // ارتفاع التمرير
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     physics: const BouncingScrollPhysics(),
//                     child: Center(
//                       child: CustomTitleText(
//                         text: number,
//                         isTitle: true,
//                         screenHeight: 300.sp,
//                         textColor: numberColor,
//                         textAlign: TextAlign.center,
//                         // عند التمرير ما نقيّد بـ maxLines
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : Center(
//                 child: CustomTitleText(
//                   text: number,
//                   isTitle: true,
//                   screenHeight: 300.sp,
//                   textColor: numberColor,
//                   textAlign: TextAlign.center,
//                   maxLines: numberMaxLines, // بدون تمرير: سطرين مثلاً
//                 ),
//               ),
//       ),
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: SvgPicture.asset(image, height: 28.h),
//         ),
//         CustomTitleText(
//           text: title,
//           isTitle: true,
//           screenHeight: 350.sp,
//           textAlign: TextAlign.center,
//           textColor: titleColor,
//           maxLines: titleMaxLines,
//         ),
//         SizedBox(height: 5.h),
//         badge,
//       ],
//     );
//   }
// }
