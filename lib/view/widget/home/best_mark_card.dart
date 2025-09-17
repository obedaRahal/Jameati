import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

// class BestMarkCard extends StatelessWidget {
//   //final double heightMediaQ;
//   final String title;
//   final String imageAsset;
//   final String finalText;
//   final String mark;
//   final List<String> avatars;

//   const BestMarkCard({
//     super.key,
//     //required this.heightMediaQ,
//     required this.title,
//     required this.imageAsset,
//     required this.finalText,
//     required this.mark,
//     required this.avatars,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).extension<CustomAppColors>()!;
//     return CustomBackgroundWithWidget(
//       height: 150.h,
//       width: 365.w,
//       color: colors.greyBackgrondHome_darkPrimary,
//       borderRadius: 20,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 8.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               width: 220.w,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // ✅ Scrollable title
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         CustomTitleText(
//                           text: title,
//                           isTitle: true,
//                           screenHeight: 400.sp,
//                           textColor: colors.titleText,
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           width: 3.w,
//                         ),
//                         Image.asset(
//                           MyImageAsset.lamp2,
//                           height: 25.h,
//                         )
//                       ],
//                     ),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.h),
//                     child: CustomBackgroundWithWidget(
//                       height: 30.h,
//                       width: 280.w,
//                       color: Get.find<ThemeController>().isDark
//                           ? const Color(0xff3F3F3F)
//                           : AppColors.greyInput,
//                       borderRadius: 20,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomBackgroundWithWidget(
//                               height: 45.h,
//                               width: 70.w,
//                               color: colors.primary_cyen,
//                               borderRadius: 20,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.h),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       mark,
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontFamily: MyFonts.hekaya,
//                                         color: colors.backgroundWhite,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(width: 5.w),
//                                     Container(
//                                       height: 23.h,
//                                       width: 22.w,
//                                       decoration: BoxDecoration(
//                                         color: colors.backgroundWhite,
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Icon(
//                                         Icons.check,
//                                         color: AppColors.primary,
//                                         size: 22.h,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 30.w,
//                             ),
//                             Text(
//                               finalText,
//                               style: TextStyle(
//                                 fontSize: 15.sp,
//                                 fontFamily: MyFonts.hekaya,
//                                 color: AppColors.greyHintDark,
//                               ),
//                             ),
//                             SizedBox(width: 30.w),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),

//                   // ✅ avatars
//                   Container(
//                     alignment: Alignment.centerRight,
//                     //width: 250.w,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: avatars
//                             .map((avatarPath) => Row(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(30),
//                                       child: Image.asset(
//                                         avatarPath,
//                                         height: 35.h,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 3),
//                                   ],
//                                 ))
//                             .toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 5.w),
//             CustomBackgroundWithWidget(
//               height: 130.h,
//               width: 130.h,
//               color: AppColors.greyInput,
//               borderRadius: 20,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: SvgPicture.asset(
//                   imageAsset,
//                   height: 60.h,
//                 ),
//               ),
//             ),
//             SizedBox(width: 8.w),
//           ],
//         ),
//       ),
//     );
//   }
// }

class BestMarkCard extends StatelessWidget {
  // بدّل: imageAsset إلزامي -> خياري مع دعم رابط شبكة
  final String? imageAsset; // مسار أصل (يمكن يكون svg/png)
  final String? imageUrl; // رابط شبكة (svg/png)
  final String title;
  final String finalText;
  final String mark;
  final List<String> avatars; // قد تكون روابط أو أصول

  const BestMarkCard({
    super.key,
    required this.title,
    required this.finalText,
    required this.mark,
    required this.avatars,
    this.imageAsset,
    this.imageUrl,
  });

  bool _isSvg(String path) => path.toLowerCase().endsWith('.svg');
  bool _isNetwork(String path) => path.startsWith('http');

  Widget _buildImageBox(double size) {
    final radius = BorderRadius.circular(20);

    // أولوية: لو فيه رابط شبكة استعمله، وإلا استخدم الأصل
    if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
      final url = imageUrl!;
      return ClipRRect(
        borderRadius: radius,
        child: _isSvg(url)
            ? SvgPicture.network(url, height: size)
            : Image.network(url, height: size, fit: BoxFit.cover),
      );
    } else if (imageAsset != null && imageAsset!.trim().isNotEmpty) {
      final asset = imageAsset!;
      return ClipRRect(
        borderRadius: radius,
        child: _isSvg(asset)
            ? SvgPicture.asset(asset, height: size)
            : Image.asset(asset, height: size, fit: BoxFit.cover),
      );
    } else {
      // Placeholder بسيط
      return Container(
        decoration: BoxDecoration(
          color: AppColors.greyInput,
          borderRadius: radius,
        ),
        alignment: Alignment.center,
        child: Icon(Icons.image, size: size * 0.5, color: Colors.grey),
      );
    }
  }

  Widget _buildAvatar(String p) {
    final w = 35.h;
    final img = _isNetwork(p)
        ? Image.network(p, height: w, width: w, fit: BoxFit.cover)
        : Image.asset(p, height: w, width: w, fit: BoxFit.cover);
    return Row(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(30), child: img),
        const SizedBox(width: 3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return CustomBackgroundWithWidget(
      height: 150.h,
      width: 360.w,
      color: colors.greyBackgrondHome_darkPrimary,
      borderRadius: 20,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                width: 210.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // العنوان
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          
                          Image.asset(MyImageAsset.lamp2, height: 25.h),
                          SizedBox(width: 3.w),
                          CustomTitleText(
                            text: title,
                            isTitle: true,
                            screenHeight: 400.sp,
                            textColor: colors.titleText,
                            textAlign: TextAlign.center,
                          ),
                          
                        ],
                      ),
                    ),
              
                    // شريط الدرجات
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.h),
                        child: CustomBackgroundWithWidget(
                          height: 30.h,
                          width: 280.w,
                          color: Get.find<ThemeController>().isDark
                              ? const Color(0xff3F3F3F)
                              : AppColors.greyInput,
                          borderRadius: 20,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomBackgroundWithWidget(
                                  height: 45.h,
                                  width: 60.w,
                                  color: colors.primary_cyen,
                                  borderRadius: 20,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          mark,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: MyFonts.hekaya,
                                            color: colors.backgroundWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Container(
                                          height: 23.h,
                                          width: 22.w,
                                          decoration: BoxDecoration(
                                            color: colors.backgroundWhite,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Icon(Icons.check,
                                              color: AppColors.primary, size: 22.h),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  finalText,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: MyFonts.hekaya,
                                    color: AppColors.greyHintDark,
                                  ),
                                ),
                                SizedBox(width: 25.w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              
                    // avatars
                    Container(
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: avatars.map(_buildAvatar).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.w),

            // صورة المجموعة
            CustomBackgroundWithWidget(
              height: 120.h,
              width: 120.h,
              color: colors.greyBackgrondHome_darkPrimary,
              borderRadius: 20,
              child:
              _buildImageBox(100.h),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
