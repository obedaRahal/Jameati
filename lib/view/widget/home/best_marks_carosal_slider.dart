import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/home/best_mark_card.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
class BestMarkCarosalSlider extends StatelessWidget {
  const BestMarkCarosalSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final controller = Get.find<HomeControllerImp>();

    return GetBuilder<HomeControllerImp>(
      id: "topProject",
      builder: (c) {
        final items = c.listTopPRoject;

        if (items.isEmpty) {
          return SizedBox(
            height: 140,
            child: Center(
              child: CustomTitleText(
                text: "لا توجد بيانات لعرض أفضل المشاريع لهذا العام.",
                isTitle: true,
                screenHeight: 400.sp,
                textColor: colors.titleText,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return CarouselSlider.builder(
          carouselController: c.carouselController,
          itemCount: items.length,
          itemBuilder: (context, index, realIdx) {
            final item = items[index];
            final g = item.grades;

            final pres = g?.presentationGrade ?? 0;
            final proj = g?.projectGrade ?? 0;
            final total = g?.total ?? (pres + proj);

            // صور الأعضاء (قد تكون null) -> فلتر الفارغ
            final avatarList = (item.members ?? [])
                .map((m) => m.profileImage)
                .whereType<String>() // يحذف null
                .where((s) => s.trim().isNotEmpty)
                .toList();

            return BestMarkCard(
              title: item.ideaTitle ?? item.name ?? "أفضل مشروع",
              // مرّر إمّا رابط الشبكة أو خليه null لو مو موجود
              imageUrl: item.groupImage,
              // أو لو عندك أيقونة افتراضية SVG من الأصول:
              // imageAsset: MyImageAsset.groupNoPic,

              // نص الدرجات
              finalText: "العرض: $pres / المشروع: $proj",
              mark: "$total",

              // مرّر روابط أو أصول؛ الودجت يتعرّف تلقائيًا
              avatars: avatarList.isNotEmpty
                  ? avatarList
                  : [MyImageAsset.profileNoPic, MyImageAsset.profileNoPic], // بدائل
            );
          },
          options: CarouselOptions(
            height: 140,
            viewportFraction: 1.1,
            autoPlay: true,
            reverse: true,
            initialPage: controller.carouselCurrentIndex.value,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              controller.carouselCurrentIndex.value = index;
            },
          ),
        );
      },
    );
  }
}
