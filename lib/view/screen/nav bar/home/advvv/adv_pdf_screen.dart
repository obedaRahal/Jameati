import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/adv/adv_pdf_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/screen/nav%20bar/home/advvv/adv_img_screen.dart';
import 'package:project_manag_ite/view/widget/home/custom_indicator_with_text_row.dart';
import 'package:project_manag_ite/view/widget/home/new_ads_and_ads_text_row.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
import 'package:project_manag_ite/view/widget/search/filter_button.dart';

class AdvPdfScreen extends StatelessWidget {
  const AdvPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<AdvPdfControllerImp>();
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
                  text: "اعلانات الملفات",
                  isTitle: true,
                  screenHeight: 600.sp,
                  textColor: colors.titleText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Obx(() => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: controller.screenPart.map((filter) {
                          return FilterButton(
                            text: filter,
                            isSelected:
                                controller.selectedScreenPart.value == filter,
                            onTap: () {
                              controller.selectedScreenPart.value = filter;
                              debugPrint("تم اختيار : $filter");
                              if (filter == "السنة الماضية") {
                                controller.getListOfLastYearPdfAdv();
                              }
                              if (filter == "المفضلة") {
                                controller.getListFavoritePdfAdv();
                              }
                            },
                          );
                        }).toList(),
                      )),
                )),
            Divider(
              color: colors.greyInput_greyInputDark,
              thickness: 2,
            ),
            SizedBox(
              height: 10.h,
            ),
            // بعد الـ Divider والـ SizedBox التي قبله
            Expanded(
              child: Obx(() {
                final selected = controller.selectedScreenPart.value;
                if (selected == "السنة الماضية") {
                  return LastYearSection(colors: colors);
                } else if (selected == "المفضلة") {
                  return FavoriteSection(colors: colors);
                } else {
                  // "الكل"
                  return AllSection(colors: colors);
                }
              }),
            ),
          ],
        ),
      )),
    );
  }
}

class AllSection extends StatelessWidget {
  final CustomAppColors colors;
  const AllSection({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdvPdfControllerImp>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // المؤشر
        Obx(
          () => CustomIndicatorWithTextRow(
            pageCount: controller.latestPdfAdvList.length,
            text: "الأحدث",
            pageController: PageController(
              initialPage: controller.carouselCurrentIndex.value,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        SizedBox(height: 16.h),

        // الكاروزل
        Obx(() {
          if (controller.latestPdfAdvList.isEmpty) {
            return SizedBox(
              height: 140.h,
              child: Center(
                child: Text("لا توجد إعلانات حالياً",
                    style: TextStyle(fontSize: 14.sp)),
              ),
            );
          }

          return CarouselSlider.builder(
            carouselController: controller.carouselController,
            itemCount: controller.latestPdfAdvList.length,
            itemBuilder: (context, index, realIdx) {
              final adv = controller.latestPdfAdvList[index];
              final title = (adv.title ?? "").trim();

              return NewestAdvItemCard(
                title: title,
                date: adv.createdAt ?? "--/--/--",
                backgroundColor: colors.greyBackgrondHome_darkPrimary,
                titleColor: colors.titleText,
                imageAsset: MyImageAsset.pdfAdv,
                height: 120,
                
                isFavorite: adv.isFavorite ?? false,
                onDownload: () => controller.downloadAdv(adv.id ?? 0),
                onFavorite: () {
                  final id = adv.id ?? 0;
                  if (adv.isFavorite ?? false) {
                    controller.deleteFromFavorite(id);
                  } else {
                    controller.addToFavorite(id);
                  }
                },
                width: 290.w,
              );
            },
            options: CarouselOptions(
              height: 120.h,
              viewportFraction: 0.88,
              autoPlay: true,
              reverse: true,
              initialPage: controller.carouselCurrentIndex.value,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                controller.carouselCurrentIndex.value = index;
              },
            ),
          );
        }),

        SizedBox(height: 16.h),
        Divider(
          color: colors.greyInput_greyInputDark,
          thickness: 2,
          endIndent: 40,
          indent: 40,
        ),
        SizedBox(height: 16.h),

        // العنوان "الأقدم"
        GetBuilder<AdvPdfControllerImp>(
          builder: (c) => NewAdsAndAdsTextRow(
            text: "الأقدم",
            title: "اعلان",
            numOfAdv: "${c.lastCurrentYearPdfAdvList.length}",
            colors: colors,
          ),
        ),
        SizedBox(height: 16.h),

        // قائمة السنة الحالية
        Expanded(
          child: GetBuilder<AdvPdfControllerImp>(
            builder: (c) {
              if (c.lastCurrentYearPdfAdvList.isEmpty) {
                return Center(
                  child: Text("لا توجد إعلانات للسنة الحالية",
                      style: TextStyle(fontSize: 14.sp)),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: c.lastCurrentYearPdfAdvList.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final adv = c.lastCurrentYearPdfAdvList[index];

                  return NewestAdvItemCard(
                    title: adv.title ?? "",
                    date: adv.createdAt ?? "--/--/--",
                    backgroundColor: colors.greyBackgrondHome_darkPrimary,
                    titleColor: colors.titleText,
                    imageAsset: MyImageAsset.pdfAdv,
                    isFavorite: adv.isFavorite ?? false,
                    onDownload: () {
                      final id = adv.id ?? 0;
                      final path = adv.attachmentPath ?? "";
                      if (path.isNotEmpty) {
                        controller.downloadAdv(id);
                      } else {
                        debugPrint("لا يوجد مرفق للتحميل");
                      }
                    },
                    onFavorite: () {
                      final id = adv.id ?? 0;
                      if (adv.isFavorite ?? false) {
                        controller.deleteFromFavorite(id);
                      } else {
                        controller.addToFavorite(id);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class LastYearSection extends StatelessWidget {
  final CustomAppColors colors;
  const LastYearSection({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdvPdfControllerImp>();

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // العنوان "الأقدم"
      GetBuilder<AdvPdfControllerImp>(
        builder: (controller) => NewAdsAndAdsTextRow(
          text: "السنة الماضية",
          title: "اعلان",
          numOfAdv: "${controller.lastYearAdvList.length}",
          colors: colors,
        ),
      ),
      SizedBox(height: 16.h),

      // قائمة السنة الحالية
      Expanded(
        child: GetBuilder<AdvPdfControllerImp>(
          builder: (c) {
            if (c.lastYearAdvList.isEmpty) {
              return Center(
                child: Text("لا توجد إعلانات للسنة الماضية",
                    style: TextStyle(fontSize: 14.sp)),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: c.lastYearAdvList.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final adv = c.lastYearAdvList[index];

                return NewestAdvItemCard(
                  title: adv.title ?? "",
                  date: adv.createdAt ?? "--/--/--",
                  backgroundColor: colors.greyBackgrondHome_darkPrimary,
                  titleColor: colors.titleText,
                  imageAsset: MyImageAsset.pdfAdv,
                  isFavorite: adv.isFavorite ?? false,
                  onDownload: () {
                    final id = adv.id ?? 0;
                    final path = adv.attachmentPath ?? "";
                    if (path.isNotEmpty) {
                      controller.downloadAdv(id);
                    } else {
                      debugPrint("لا يوجد مرفق للتحميل");
                    }
                  },
                  onFavorite: () {
                    final id = adv.id ?? 0;
                    if (adv.isFavorite ?? false) {
                      controller.deleteFromFavorite(id);
                    } else {
                      controller.addToFavorite(id);
                    }
                  },
                );
              },
            );
          },
        ),
      )
    ]);
  }
}

class FavoriteSection extends StatelessWidget {
  final CustomAppColors colors;
  const FavoriteSection({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdvPdfControllerImp>();

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // العنوان "الأقدم"
      GetBuilder<AdvPdfControllerImp>(
        builder: (controller) => NewAdsAndAdsTextRow(
          text: "المفضلة",
          title: "اعلان",
          numOfAdv: "${controller.favorotePdfList.length}",
          colors: colors,
        ),
      ),
      SizedBox(height: 16.h),

      // قائمة السنة الحالية
      Expanded(
        child: GetBuilder<AdvPdfControllerImp>(
          builder: (controller) {
            if (controller.favorotePdfList.isEmpty) {
              return Center(
                child: Text("لا توجد إعلانات للسنة الماضية",
                    style: TextStyle(fontSize: 14.sp)),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.favorotePdfList.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final adv = controller.favorotePdfList[index];

                return NewestAdvItemCard(
                  title: adv.title ?? "",
                  date: adv.createdAt ?? "--/--/--",
                  backgroundColor: colors.greyBackgrondHome_darkPrimary,
                  titleColor: colors.titleText,
                  imageAsset: MyImageAsset.pdfAdv,
                  isFavorite: adv.isFavorite ?? false,
                  onDownload: () {
                    final id = adv.id ?? 0;
                    final path = adv.attachmentPath ?? "";
                    if (path.isNotEmpty) {
                      controller.downloadAdv(id);
                    } else {
                      debugPrint("لا يوجد مرفق للتحميل");
                    }
                  },
                  onFavorite: () {
                    final id = adv.id ?? 0;
                    if (adv.isFavorite ?? false) {
                      controller.deleteFromFavorite(id);
                    } else {
                      controller.addToFavorite(id);
                    }
                  },
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
