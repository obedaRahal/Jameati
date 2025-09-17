import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/adv/adv_img_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/icon_title_info_row.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/text_icon_chip.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/home/custom_indicator_with_text_row.dart';
import 'package:project_manag_ite/view/widget/home/new_ads_and_ads_text_row.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
import 'package:project_manag_ite/view/widget/search/filter_button.dart';

class AdvImgScreen extends StatelessWidget {
  const AdvImgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<AdvImgControllerImp>();
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
                  text: "اعلانات الصور",
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
                                controller.getListOfLastYearImgAdv();
                              }
                              if (filter == "المفضلة") {
                                controller.getListFavoriteImgAdv();
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
    final controller = Get.find<AdvImgControllerImp>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // المؤشر
        Obx(
          () => CustomIndicatorWithTextRow(
            pageCount: controller.latestImgAdvList.length,
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
          if (controller.latestImgAdvList.isEmpty) {
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
            itemCount: controller.latestImgAdvList.length,
            itemBuilder: (context, index, realIdx) {
              final adv = controller.latestImgAdvList[index];
              final title = (adv.title ?? "").trim();

              return NewestAdvItemCard(
                title: title,
                date: adv.createdAt ?? "--/--/--",
                backgroundColor: colors.greyBackgrondHome_darkPrimary,
                titleColor: colors.titleText,
                imageAsset: MyImageAsset.imgAdv,
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
        GetBuilder<AdvImgControllerImp>(
          builder: (c) => NewAdsAndAdsTextRow(
            text: "الأقدم",
            title: "اعلان",
            numOfAdv: "${c.lastCurrentYearImgAdvList.length}",
            colors: colors,
          ),
        ),
        SizedBox(height: 16.h),

        // قائمة السنة الحالية
        Expanded(
          child: GetBuilder<AdvImgControllerImp>(
            builder: (c) {
              if (c.lastCurrentYearImgAdvList.isEmpty) {
                return Center(
                  child: Text("لا توجد إعلانات للسنة الحالية",
                      style: TextStyle(fontSize: 14.sp)),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: c.lastCurrentYearImgAdvList.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final adv = c.lastCurrentYearImgAdvList[index];

                  return NewestAdvItemCard(
                    title: adv.title ?? "",
                    date: adv.createdAt ?? "--/--/--",
                    backgroundColor: colors.greyBackgrondHome_darkPrimary,
                    titleColor: colors.titleText,
                    imageAsset: MyImageAsset.imgAdv,
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
    final controller = Get.find<AdvImgControllerImp>();

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // العنوان "الأقدم"
      GetBuilder<AdvImgControllerImp>(
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
        child: GetBuilder<AdvImgControllerImp>(
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
                  imageAsset: MyImageAsset.imgAdv,
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
    final controller = Get.find<AdvImgControllerImp>();

    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // العنوان "الأقدم"
      GetBuilder<AdvImgControllerImp>(
        builder: (controller) => NewAdsAndAdsTextRow(
          text: "المفضلة",
          title: "اعلان",
          numOfAdv: "${controller.favoroteImgList.length}",
          colors: colors,
        ),
      ),
      SizedBox(height: 16.h),

      // قائمة السنة الحالية
      Expanded(
        child: GetBuilder<AdvImgControllerImp>(
          builder: (controller) {
            if (controller.favoroteImgList.isEmpty) {
              return Center(
                child: Text("لا توجد إعلانات للسنة الماضية",
                    style: TextStyle(fontSize: 14.sp)),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.favoroteImgList.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final adv = controller.favoroteImgList[index];

                return NewestAdvItemCard(
                  title: adv.title ?? "",
                  date: adv.createdAt ?? "--/--/--",
                  backgroundColor: colors.greyBackgrondHome_darkPrimary,
                  titleColor: colors.titleText,
                  imageAsset: MyImageAsset.imgAdv,
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

class NewestAdvItemCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onDownload;
  final VoidCallback onFavorite;
  final String imageAsset;

  final double height;
  final double width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final bool isFavorite;
  final double picHight;
  final double picWidth;

  const NewestAdvItemCard(
      {super.key,
      required this.title,
      required this.date,
      required this.onDownload,
      required this.onFavorite,
      required this.imageAsset,
      this.height = 120,
      this.width = 365,
      this.borderRadius = 20,
      this.backgroundColor,
      this.borderColor,
      this.titleColor,
      this.isFavorite = false,
      this.picHight = 70,
      this.picWidth = 10});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final bg = backgroundColor ?? const Color(0xFFF5F6F8);
    final brd = borderColor ?? Colors.grey.shade400;
    final tColor = titleColor ?? Colors.black87;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: brd),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: CustomBackgroundWithWidget(
        height: height.h,
        width: width.w,
        color: bg,
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// النصوص والأزرار
              SizedBox(
                width: (width - 120).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // العنوان قابل للتمرير أفقيًا
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTitleText(
                              text: title,
                              isTitle: true,
                              screenHeight: 400.sp,
                              textColor: tColor,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: IconTitleInfoRow(
                        icon: Icons.timer_outlined,
                        title: "تاريخ النشر :  ",
                        info: date,
                      ),
                    ),

                    Row(
                      children: [
                        // زر المفضلة بشكل دائرة
                        GestureDetector(
                          onTap: onFavorite,
                          child: Container(
                            height: 28.h,
                            width: 28.h,
                            decoration: BoxDecoration(
                              color: colors.cyenToWhite_greyInputDark,
                              border: Border.all(
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.red, // AppColors.red
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_sharp,
                              size: 20.h,
                              color: Colors.red, // AppColors.red
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),

                        // زر التنزيل "TextIconChip"
                        TextIconChip(
                          onTap: onDownload,
                          backgroundHeight: 26.h,
                          backgroundWidth: 75.w,
                          icon: Icons.file_download_outlined,
                          text: "تنزيل",
                          textIconColor: Colors.grey, // AppColors.greyHintLight
                          // backgroundColor: bg, // لو حبيت تستخدم خلفية مخصصة
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 5.w),

              // الصورة على اليمين
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: SvgPicture.asset(
                  imageAsset,
                  height: picHight.h,
                  width: picWidth.w,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
