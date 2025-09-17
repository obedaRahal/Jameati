
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/statistic_widget.dart';

class StatisticAllRow extends StatelessWidget {
  const StatisticAllRow({super.key, required this.numOfStudent, required this.numOfDoctor, required this.numOfGroups});

  final String numOfStudent ;
  final String numOfDoctor ;
  final String numOfGroups ;
  

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatisticWidget(
            image: MyImageAsset.statistic3,
            title: "عدد الطلاب",
            numberMaxLines: 1,
            titleColor: AppColors.greyHintLight,
            number: numOfStudent,
            numberColor: AppColors.red,
            numberBackgroundColor:
              Get.find<ThemeController>().isDark
              ? AppColors.darkPrimary
             : AppColors.redPink,
          ),
          const VerticalDivider(
            color: AppColors.greyHintLight, // أو أي لون مناسب
            thickness: 1,
            width: 20,
            indent: 10,
            endIndent: 10,
          ),
          StatisticWidget(
            //heightMediaQ: MediaQuery.of(context).size.height,
            image: MyImageAsset.statistic2,
            title: "عدد المجموعات",
            titleColor: AppColors.greyHintLight,
            numberMaxLines: 1,
            number: numOfGroups,
            numberColor: AppColors.yellow,
            numberBackgroundColor:
            Get.find<ThemeController>().isDark
              ? AppColors.darkPrimary
            : AppColors.yellowWhite,
          ),
          const VerticalDivider(
            color: AppColors.greyHintLight, // أو أي لون مناسب
            thickness: 1,
            width: 20,
            indent: 10,
            endIndent: 10,
          ),
          StatisticWidget(
            //heightMediaQ: MediaQuery.of(context).size.height,
            image: MyImageAsset.statistic1,
            title: "عدد المشرفين",
            titleColor: AppColors.greyHintLight,
            number: numOfDoctor,
            numberMaxLines: 1,
            numberColor: AppColors.cyen,
            numberBackgroundColor:
            Get.find<ThemeController>().isDark
              ? AppColors.darkPrimary
            : AppColors.cyenToWhite,
          ),
        ],
      ),
    );
  }
}


// class StatisticAllRow extends StatelessWidget {
//   const StatisticAllRow({
//     super.key,
//     required this.numOfStudent,
//     required this.numOfDoctor,
//     required this.numOfGroups,
//   });

//   final String numOfStudent;
//   final String numOfDoctor;
//   final String numOfGroups;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       physics: const BouncingScrollPhysics(),
//       child: IntrinsicHeight( // يجعل الـ VerticalDivider بطول الصف
//         child: Row(
//           mainAxisSize: MainAxisSize.min, // مهم داخل Scroll
//           children: [
//             StatisticWidget(
//               image: MyImageAsset.statistic3,
//               title: "عدد الطلاب",
//               numberMaxLines: 1,
//               titleColor: AppColors.greyHintLight,
//               number: numOfStudent,
//               numberColor: AppColors.red,
//               numberBackgroundColor: Get.find<ThemeController>().isDark
//                   ? AppColors.darkPrimary
//                   : AppColors.redPink,
//             ),

//             SizedBox(width: 12.w),
//             _VDivider(),
//             SizedBox(width: 12.w),

//             StatisticWidget(
//               image: MyImageAsset.statistic2,
//               title: "عدد المجموعات",
//               titleColor: AppColors.greyHintLight,
//               numberMaxLines: 1,
//               number: numOfGroups,
//               numberColor: AppColors.yellow,
//               numberBackgroundColor: Get.find<ThemeController>().isDark
//                   ? AppColors.darkPrimary
//                   : AppColors.yellowWhite,
//             ),

//             SizedBox(width: 12.w),
//             _VDivider(),
//             SizedBox(width: 12.w),

//             StatisticWidget(
//               image: MyImageAsset.statistic1,
//               title: "عدد المشرفين",
//               titleColor: AppColors.greyHintLight,
//               number: numOfDoctor,
//               numberMaxLines: 1,
//               numberColor: AppColors.cyen,
//               numberBackgroundColor: Get.find<ThemeController>().isDark
//                   ? AppColors.darkPrimary
//                   : AppColors.cyenToWhite,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // فاصل عمودي بطول الصف
// class _VDivider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: 12.h),
//       child:const SizedBox(
//         height: double.infinity,
//         child: VerticalDivider(
//           color: AppColors.greyHintLight,
//           thickness: 1,
//           width: 1, // عرض الخط نفسه، والمسافة حوالينه نعطيها بـ SizedBox
//         ),
//       ),
//     );
//   }
// }
