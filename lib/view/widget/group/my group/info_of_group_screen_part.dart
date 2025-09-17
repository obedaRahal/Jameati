import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/custom_textformfeild.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/custom_skill_section.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/home/custom_select_button.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class InfoOfGroupScreenPart extends StatelessWidget {
  const InfoOfGroupScreenPart({super.key});

  static const Map<String, String> specialitiesMap = {
    "UI/UX": "UI/UX",
    "فرونت ويب": "front_web",
    "فرونت موبايل": "front_mobile",
    "باك ايند": "Backend",
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<MyGroupControllerImp>();

    final Map<String, String> privacyOptions = {
      "عام": "public",
      "خاص": "private",
    };

    return GetBuilder<MyGroupControllerImp>(
    id: "infoGroup",
      builder: (c) {
        if (c.statusRequest == StatusRequest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.statusRequest != StatusRequest.success) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTitleText(
                  text: "تعذّر جلب معلومات المجموعة",
                  isTitle: true,
                  screenHeight: 600.sp,
                  textColor: colors.titleText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: controller.getMyGroupInfo,
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 16.h),

            /// اسم المجموعة + صورة
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTitleText(
                      text: "اسم المجموعة",
                      isTitle: true,
                      screenHeight: 450.sp,
                      textColor: colors.titleText,
                      textAlign: TextAlign.center,
                      horizontalPadding: 8.h,
                    ),
                    SizedBox(
                      width: 270.w,
                      height: 40.h,
                      child: CustomTextFormFeild(
                        hintText: "ادخل اسم الغروب",
                        iconData: Icons.abc,
                        myComtroller: c.groupName,
                        validator: (x) {},
                        isNumber: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
                Obx(() => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ✅ صورة المستخدم من الجهاز إذا موجودة
                        if (controller.pickedImage.value != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.pickedImage.value!,
                              height: 70.h,
                              width: 65.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (controller.groupImageUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.groupImageUrl!,
                              height: 70.h,
                              width: 65.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, err, __) {
                                debugPrint('Image error: $err');
                                return SvgPicture.asset(MyImageAsset.groupPic,
                                    height: 70.h,
                                    width: 65.w,
                                    fit: BoxFit.cover);
                              },
                            ),
                          )
                        else
                          SvgPicture.asset(
                            MyImageAsset.groupPic,
                            height: 70.h,
                            width: 65.w,
                            fit: BoxFit.cover,
                          ),
                        Positioned(
                          bottom: -8,
                          left: -8,
                          child: InkWell(
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                              );
                              if (pickedFile != null) {
                                controller.pickedImage.value =
                                    File(pickedFile.path);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(5.w),
                              child: Icon(
                                Icons.camera_alt,
                                size: 18.h,
                                color: AppColors.greyHintDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),

            SizedBox(height: 16.h),

            CustomTitleText(
              text: "وصف المجموعة",
              isTitle: true,
              screenHeight: 450.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
              horizontalPadding: 8.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: colors.greyInput_greyInputDark,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextFormField(
                controller: c.groupDescription,
                maxLines: 4,
                style: TextStyle(
                  color: colors.titleText,
                  fontFamily: MyFonts.hekaya,
                  fontSize: 15.sp,
                ),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: "ادخل وصف المجموعة",
                  hintStyle: TextStyle(
                    color: AppColors.greyHintLight,
                    fontSize: 14.sp,
                    fontFamily: MyFonts.hekaya,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            CustomTitleText(
              text: "الاختصاص المطلوب",
              isTitle: true,
              screenHeight: 450.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
              horizontalPadding: 8.h,
            ),
            SizedBox(height: 12.h),
            Obx(() {
              return Wrap(
                spacing: 8.w,
                children: specialitiesMap.entries.map((entry) {
                  final displayName = entry.key;
                  final actualValue = entry.value;
                  final isSelected =
                      c.selectedSpecialities.contains(actualValue);

                  return GestureDetector(
                    onTap: () => c.toggleSpeciality(actualValue),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.primary_cyen
                            : colors.greyInput_greyInputDark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: MyFonts.hekaya,
                          color: isSelected
                              ? colors.cyenToWhite_greyInputDark
                              : AppColors.greyHintLight,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),

            SizedBox(height: 16.h),

            CustomTitleText(
              text: "المهارات المطلوبة",
              isTitle: true,
              screenHeight: 450.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
              horizontalPadding: 8.h,
            ),
            SizedBox(height: 16.h),
            CustomSkillSection(
              horizontalPadding: 0,
              title: "باك ايند",
              skillsKey: "Backend",
              isExpanded: c.isBackEndOn,
              selectedFrameworkNeededSkills: c.selectedFrameworkNeededSkills,
              skillsBySpeciality: c.skillsBySpeciality,
              selectedSpecialities: c.selectedSpecialities,
            ),
            CustomSkillSection(
              title: "فرونت موبايل",
              skillsKey: "front_mobile",
              horizontalPadding: 0,
              isExpanded: c.isFrontEndMobOn,
              selectedFrameworkNeededSkills: c.selectedFrameworkNeededSkills,
              skillsBySpeciality: c.skillsBySpeciality,
              selectedSpecialities: c.selectedSpecialities,
            ),
            CustomSkillSection(
              title: "فرونت ويب",
              skillsKey: "front_web",
              horizontalPadding: 0,
              isExpanded: c.isFrontEndWebOn,
              selectedFrameworkNeededSkills: c.selectedFrameworkNeededSkills,
              skillsBySpeciality: c.skillsBySpeciality,
              selectedSpecialities: c.selectedSpecialities,
            ),

            SizedBox(height: 16.h),

            CustomTitleText(
              text: "نوع المجموعة",
              isTitle: true,
              screenHeight: 450.sp,
              textColor: colors.titleText,
              textAlign: TextAlign.center,
              horizontalPadding: 8.h,
            ),
            SizedBox(height: 16.h),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: privacyOptions.entries.map((entry) {
                    final displayText = entry.key;
                    final storedValue = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CustomSelectButton(
                        colors: colors,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 3.h),
                        text: displayText,
                        isSelected: c.privateOrPublic.value == storedValue,
                        onTap: () {
                          c.privateOrPublic.value = storedValue;
                        },
                      ),
                    );
                  }).toList(),
                )),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: colors.greyInput_greyInputDark,
                thickness: 2,
                endIndent: 30,
                indent: 30,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    debugPrint(controller.groupName.text);
                    debugPrint(controller.groupDescription.text);
                    debugPrint(
                        controller.selectedSpecialities.toList().toString());
                    debugPrint(controller.selectedFrameworkNeededSkills
                        .toList()
                        .toString());
                    debugPrint(controller.privateOrPublic.string);
                    debugPrint(controller.pickedImage.string);
                    controller.updateGroupInfo();
                    // هنا ممكن تستدعي API updateMyGroupInfo
                  },
                  child: CustomBackgroundWithWidget(
                    height: 32.h,
                    width: 150.w,
                    color: colors.primary_cyen,
                    borderRadius: 10,
                    alignment: Alignment.center,
                    child: CustomTitleText(
                      text: "حفظ",
                      isTitle: true,
                      maxLines: 1,
                      screenHeight: 350.sp,
                      textAlign: TextAlign.center,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    debugPrint("إلغاء");
                    debugPrint("${controller.groupId}");
                  },
                  child: CustomBackgroundWithWidget(
                    height: 32.h,
                    width: 150.w,
                    color: colors.greyBackgrondHome_darkPrimary,
                    borderRadius: 10,
                    alignment: Alignment.center,
                    child: CustomTitleText(
                      text: "إلغاء",
                      isTitle: true,
                      maxLines: 1,
                      screenHeight: 350.sp,
                      textAlign: TextAlign.center,
                      textColor: Get.find<ThemeController>().isDark
                          ? AppColors.white
                          : AppColors.greyHintDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}
