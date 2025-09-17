

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/statistic_widget.dart';

class MainInfoRow extends StatelessWidget {
  const MainInfoRow(
      {super.key,
      required this.numOfStudent,
      required this.idea,
      required this.historyOfCreate,
      required this.nameOfDoctor});

  final String numOfStudent;
  final String idea;
  final String historyOfCreate;
  final String nameOfDoctor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: StatisticWidget(
              image: MyImageAsset.myGroupMainInfo1,
              title: "الأعضاء",
              titleColor: AppColors.greyHintLight,
              number: numOfStudent,
              numberColor: AppColors.red,
              numberBackgroundColor: Get.find<ThemeController>().isDark
                  ? AppColors.darkPrimary
                  : AppColors.white,
            ),
          ),
          const SizedBox(
            width: 10,
            child: VerticalDivider(
              color: AppColors.greyHintLight,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Expanded(
            child: StatisticWidget(
              image: MyImageAsset.myGroupMainInfo2,
              title: "الفكرة",
              titleColor: AppColors.greyHintLight,
              numberMaxLines: 6,
              number: idea,
              numberColor: AppColors.yellow,
              numberBackgroundColor: Get.find<ThemeController>().isDark
                  ? AppColors.darkPrimary
                  : AppColors.white,
            ),
          ),
          const SizedBox(
            width: 10,
            child: VerticalDivider(
              color: AppColors.greyHintLight,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Expanded(
            child: StatisticWidget(
              image: MyImageAsset.myGroupMainInfo3,
              title: "تاريخ الانشاء",
              titleColor: AppColors.greyHintLight,
              number: historyOfCreate,
              numberColor: AppColors.green,
              numberBackgroundColor: Get.find<ThemeController>().isDark
                  ? AppColors.darkPrimary
                  : AppColors.white,
            ),
          ),
          const SizedBox(
            width: 10,
            child: VerticalDivider(
              color: AppColors.greyHintLight,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Expanded(
            child: StatisticWidget(
              image: MyImageAsset.myGroupMainInfo4,
              title: "المشرف",
              titleColor: AppColors.greyHintLight,
              number: nameOfDoctor,
              numberColor: AppColors.cyen,
              numberBackgroundColor: Get.find<ThemeController>().isDark
                  ? AppColors.darkPrimary
                  : AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
