import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/custom_textformfeild.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/custom_skill_section.dart';
import 'package:project_manag_ite/view/widget/group/create%20group/group_speciality_selector.dart';
import 'package:project_manag_ite/view/widget/home/custom_select_button.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class CreateInfoGroup extends StatelessWidget {
  const CreateInfoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<CreateNewGroupControllerImp>();
    final Map<String, String> privacyOptions = {
      "عام": "public",
      "خاص": "private",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
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
                        myComtroller: controller.groupName,
                        validator: (x) {},
                        isNumber: false),
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ✅ صورة المستخدم (من الجهاز أو صورة افتراضية)
                      controller.pickedImage.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                controller.pickedImage.value!,
                                height: 70.h,
                                width: 65.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SvgPicture.asset(
                              MyImageAsset.groupPic,
                              height: 70.h,
                              width: 65.w,
                              fit: BoxFit.cover,
                            ),

                      // ✅ زر الكاميرا
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
                  )),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: CustomTitleText(
            text: "وصف المجموعة",
            isTitle: true,
            screenHeight: 450.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center,
            horizontalPadding: 8.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Container(
            decoration: BoxDecoration(
              color: colors.greyInput_greyInputDark,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextFormField(
              controller: controller.groupDescription,
              maxLines: 4,
              style: TextStyle(
                color: colors.titleText,
                fontFamily: MyFonts.hekaya,
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                hintTextDirection: TextDirection.rtl,
                hintText: "ادخل وصف المجموعة الخاصة بك...",
                hintStyle: TextStyle(
                  color: AppColors.greyHintLight,
                  fontSize: 14.sp,
                  fontFamily: MyFonts.hekaya,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: CustomTitleText(
            text: "الاختصاص المطلوب",
            isTitle: true,
            screenHeight: 450.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center,
            horizontalPadding: 8.h,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: const GroupSpecialitySelector(),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: CustomTitleText(
            text: "المهارات المطلوبة",
            isTitle: true,
            screenHeight: 450.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center,
            horizontalPadding: 8.h,
          ),
        ),

        SizedBox(height: 16.h),
        CustomSkillSection(
          title: "باك ايند",
          skillsKey: "Backend",
          isExpanded: controller.isBackEndOn,
          selectedFrameworkNeededSkills:
              controller.selectedFrameworkNeededSkills,
          skillsBySpeciality: controller.skillsBySpeciality,
          selectedSpecialities: controller.selectedSpecialities,
        ),
        CustomSkillSection(
          title: "فرونت موبايل",
          skillsKey: "front_mobile",
          isExpanded: controller.isFrontEndMobOn,
          selectedFrameworkNeededSkills:
              controller.selectedFrameworkNeededSkills,
          skillsBySpeciality: controller.skillsBySpeciality,
          selectedSpecialities: controller.selectedSpecialities,
        ),
        CustomSkillSection(
          title: "فرونت ويب",
          skillsKey: "front_web",
          isExpanded: controller.isFrontEndWebOn,
          selectedFrameworkNeededSkills:
              controller.selectedFrameworkNeededSkills,
          skillsBySpeciality: controller.skillsBySpeciality,
          selectedSpecialities: controller.selectedSpecialities,
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: CustomTitleText(
            text: "نوع المجموعة",
            isTitle: true,
            screenHeight: 450.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center,
            horizontalPadding: 8.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: CustomTitleText(
            horizontalPadding: 8.h,
            textAlign: TextAlign.end,
            text:
                "المجموعة العامة تظهر الى جميع المستخدمين ويمكن لأي شخص ان يقوم بارسال طلب انضمام و رؤية معلوماتها اما ان كانت خاصة فلن تظهر للمستخدمين ويتم الانضمام اليها عن طريق دعوة من قبل المشرف",
            isTitle: false,
            screenHeight: .8.sh,
            textColor: colors.greyHint_authTabUnselectedText,
          ),
        ),
        SizedBox(height: 16.h),
        Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: privacyOptions.entries.map((entry) {
                  final displayText = entry.key; // "عام" أو "خاص"
                  final storedValue = entry.value; // "public" أو "private"

                  return Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: CustomSelectButton(
                      colors: colors,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.h, vertical: 3.h),
                      text: displayText,
                      isSelected:
                          controller.privateOrPublic.value == storedValue,
                      onTap: () {
                        controller.privateOrPublic.value = storedValue;
                      },
                    ),
                  );
                }).toList(),
              ),
            )),
        //SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.all(
            16.h,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  controller.changeTab(1);
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
