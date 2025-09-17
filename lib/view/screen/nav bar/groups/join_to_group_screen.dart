import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/join_to_group_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/data/model/groups/join%20to%20group/join_to_group_item_model.dart';
import 'package:project_manag_ite/view/widget/chats/list%20of%20chats/search_bar_with_clear_widget.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class JoinToGroupScreen extends StatelessWidget {
  const JoinToGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<JoinToGroupControllerImp>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () {
          debugPrint("تم الضغط على إنشاء غروب");
          Get.toNamed(AppRoute.creatNewGroup);
        },
        child: Container(
          height: 40.h,
          width: 180.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: colors.cyenToWhite_greyInputDark,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: colors.primary_cyen,
              width: 3,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 6.w),
              Text(
                "انشاء غروب",
                style: TextStyle(
                  color: colors.primary_cyen,
                  fontFamily: MyFonts.hekaya,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.add,
                color: colors.primary_cyen,
                size: 27.h,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 18.h, left: 18.h, right: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(
                text: "الغروبات",
                isTitle: true,
                screenHeight: 800.sp,
                textColor: colors.titleText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SearchBarWithClear(
                actionWidget: CustomTitleText(
                  text: "إلغاء",
                  isTitle: true,
                  screenHeight: 550.sp,
                  textAlign: TextAlign.center,
                  textColor: AppColors.red,
                ),
                hintTextAtSearchBar: "البحث عن غروبات",
                controller: controller.searchForGroup,
                onClear: () => controller.searchForGroup.clear(),
              ),
              SizedBox(height: 16.h),
              Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: groupsData.length,
              //     itemBuilder: (context, index) {
              //       final group = groupsData[index];
              //       return JoinToGroupListItem(
              //         title: group["title"],
              //         specialitiesNeeded: List<String>.from(group["tags"]),
              //         memberCount: group["members"],
              //         onJoinTap: () {
              //           debugPrint("🟢 طلب انضمام إلى: ${group["title"]}");
              //         },
              //       );
              //     },
              //   ),
              // ),

              Expanded(
                child: GetBuilder<JoinToGroupControllerImp>(
                  builder: (controller) {
                    if (controller.groups.isEmpty) {
                      return Center(
                        child: CustomTitleText(
                          text: "لا يوجد غروبات عامة للانضمام اليها",
                          isTitle: true,
                          screenHeight: 400.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.groups.length,
                      itemBuilder: (context, index) {
                        return JoinToGroupListItem(
                          group: controller.groups[index],
                          hasJoin: controller.groups[index].hasRequestedJoin ??
                              false,
                          onJoinTap: () {
                            debugPrint(
                                " طلب انضمام إلى: ${controller.groups[index].name}");
                            debugPrint(
                                " click on id grouppppp :  ${controller.groups[index].id}");
                            controller
                                .askToJoin(controller.groups[index].id ?? 0);
                          },
                          onCancelJoinTap: () {
                            debugPrint("الغاء الطللللللللللب");
                            debugPrint(
                                " الغاء طلب انضمام إلى: ${controller.groups[index].name}");
                            debugPrint(
                                " click on id grouppppp :  ${controller.groups[index].id}");
                            controller
                                .cancelToJoin(controller.groups[index].id ?? 0);
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class JoinToGroupListItem extends StatelessWidget {
  final Groups group;
  final VoidCallback onJoinTap;
  final VoidCallback onCancelJoinTap;
  final bool hasJoin;

  const JoinToGroupListItem({
    super.key,
    required this.group,
    required this.onJoinTap,
    required this.onCancelJoinTap,
    required this.hasJoin,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    group.image ?? "",
                    height: 70.h,
                    width: 65.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        MyImageAsset.groupPic,
                        height: 70.h,
                        width: 65.w,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: CustomTitleText(
                            text: group.name ?? "",
                            isTitle: true,
                            screenHeight: 580.sp,
                            textColor: colors.titleText,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 190.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                (group.specialitiesNeeded ?? []).map((tag) {
                              return Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: CustomBackgroundWithWidget(
                                  height: 22.h,
                                  width: 90.w,
                                  color: colors.cyenToWhite_greyInputDark,
                                  borderRadius: 5,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: CustomTitleText(
                                      text: "# $tag",
                                      isTitle: false,
                                      screenHeight: 600.sp,
                                      textColor: colors.primary_cyen,
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomTitleText(
                          horizontalPadding: 4.h,
                          text: "${group.membersCount}/5",
                          isTitle: true,
                          screenHeight: 600.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.right,
                          maxLines: 2,
                        ),
                        SizedBox(width: 3.w),
                        Icon(Icons.group_add_outlined,
                            color: AppColors.primary, size: 28.h),
                      ],
                    ),
                    if (!hasJoin)
                      GetBuilder<JoinToGroupControllerImp>(
                        builder: ((controller) =>
                            controller.statusRequest == StatusRequest.loading
                                ? Center(
                                    child: Image.asset(
                                    MyImageAsset.loadingGif,
                                    height: 40.h,
                                  ))
                                : CustomBackgroundWithWidget(
                                    height: 26.h,
                                    width: 90.w,
                                    color: colors.primary_cyen,
                                    borderRadius: 15,
                                    child: InkWell(
                                      onTap: onJoinTap,
                                      child: Center(
                                        child: Text(
                                          "طلب انضمام",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: colors.backgroundWhite,
                                            fontFamily: MyFonts.hekaya,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                      ),
                    if (hasJoin)
                      GetBuilder<JoinToGroupControllerImp>(
                        builder: ((controller) =>
                            controller.statusRequest == StatusRequest.loading
                                ? Center(
                                    child: Image.asset(
                                    MyImageAsset.loadingGif,
                                    height: 40.h,
                                  ))
                                : CustomBackgroundWithWidget(
                                    height: 26.h,
                                    width: 90.w,
                                    color: colors.greyBackgrondHome_darkPrimary,
                                    borderRadius: 15,
                                    child: InkWell(
                                      onTap: onCancelJoinTap,
                                      child: Center(
                                        child: Text(
                                          "إلغاء الطلب",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: colors.titleText,
                                            fontFamily: MyFonts.hekaya,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                      ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: colors.greyInput_greyInputDark,
            thickness: 2,
            endIndent: 40.w,
            indent: 40.w,
          ),
        ],
      ),
    );
  }
}
