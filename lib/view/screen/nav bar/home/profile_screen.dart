import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_manag_ite/controller/nav_bar/home/profile_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/icon_title_info_row.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/text_icon_chip.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<ProfileControllerImp>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: GetBuilder<ProfileControllerImp>(
            builder: (c) {
              if (c.statusRequest == StatusRequest.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              // يمكنك إضافة حالة خطأ هنا إن رغبت

              return SingleChildScrollView(
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
                          text: "الملف الشخصي",
                          isTitle: true,
                          screenHeight: 600.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Divider(
                        color: colors.greyInput_greyInputDark, thickness: 2),
                    SizedBox(height: 10.h),

                    // ===== صورة + معلومات أساسية =====
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // الصورة
                          Obx(() => Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  if (c.pickedImage.value != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        c.pickedImage.value!,
                                        height: 130.h,
                                        width: 130.h,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  else if (c.groupImageUrl != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        c.groupImageUrl!,
                                        height: 130.h,
                                        width: 130.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            SvgPicture.asset(
                                                MyImageAsset.groupPic,
                                                height: 130.h,
                                                width: 130.h,
                                                fit: BoxFit.cover),
                                      ),
                                    )
                                  else
                                    SvgPicture.asset(
                                      MyImageAsset.groupPic,
                                      height: 130.h,
                                      width: 130.h,
                                      fit: BoxFit.cover,
                                    ),
                                  Positioned(
                                    bottom: -8,
                                    right: -8,
                                    child: InkWell(
                                      onTap: () async {
                                        final picker = ImagePicker();
                                        final pickedFile =
                                            await picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 80,
                                        );
                                        if (pickedFile != null) {
                                          c.pickedImage.value =
                                              File(pickedFile.path);
                                              controller.updatePrifilePic();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(5.w),
                                        child: Icon(Icons.camera_alt,
                                            size: 18.h,
                                            color: AppColors.greyHintDark),
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          SizedBox(width: 8.w),

                          // معلومات
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: CustomTitleText(
                                    text: c.displayName,
                                    isTitle: true,
                                    screenHeight: 450.sp,
                                    textColor: colors.titleText,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              IconTitleInfoRow(
                                icon: FontAwesome.calendar_check_o,
                                title: "تاريخ التسجيل  :  ",
                                info: c.displayCreatedAt,
                                infoColor: AppColors.greyHintLight,
                                width: 180,
                              ),
                              IconTitleInfoRow(
                                icon: Icons.people_outlined,
                                title: c.displayStudentStatus.isEmpty
                                    ? "—"
                                    : c.displayStudentStatus,
                                info: "",
                                width: 180,
                              ),
                              IconTitleInfoRow(
                                icon: Icons.nine_mp_outlined,
                                title: "الرقم الجامعي  :  ",
                                info: c.displayUniversityNumber,
                                width: 180,
                                titleColor: AppColors.green,
                                infoColor: AppColors.greyHintLight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 26.h),

                    // تسجيل خروج
                    SizedBox(
                      width: double.infinity,
                      child: TextIconChip(
                        onTap: () {
                          controller.logOut();
                        },
                        backgroundHeight: 40.h,
                        backgroundWidth: 130.w,
                        borderRadius: 10,
                        icon: Icons.logout_outlined,
                        text: "تسجيل الخروج",
                        textIconColor: Colors.white,
                        backgroundColor: AppColors.red,
                      ),
                    ),

                    SizedBox(height: 26.h),
                    Divider(
                        color: colors.greyInput_greyInputDark,
                        thickness: 2,
                        endIndent: 30,
                        indent: 30),
                    SizedBox(height: 26.h),

                    // سويتش الثيم
                    Row(
                      children: [
                        GetBuilder<ThemeController>(
                          builder: (tc) => ThemeModeSwitch(
                            isDark: tc.isDark,
                            onChanged: (_) => tc.toggleTheme(),
                            width: 56.w,
                            height: 28.h,
                          ),
                        ),
                        const Spacer(),
                        CustomBackgroundWithWidget(
                          height: 35.h,
                          width: 100.w,
                          color: colors.cyenToWhite_greyInputDark,
                          borderRadius: 10,
                          child: CustomTitleText(
                            text: "أساسي",
                            isTitle: true,
                            textColor: colors.primary_cyen,
                            screenHeight: 350.sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // الاسم (عرض فقط هنا حسب تصميمك)
                    CustomTitleText(
                      text: "الاسم",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: MediaQuery.of(context).size.height * .65,
                      horizontalPadding:
                          MediaQuery.of(context).size.height * .025,
                    ),
                    const SizedBox(height: 6),
                    CustomBackgroundWithWidget(
                      height: 50.h,
                      width: double.infinity,
                      color: colors.greyInput_greyInputDark,
                      borderRadius: 30,
                      alignment: Alignment.centerRight,
                      child: CustomTitleText(
                        horizontalPadding: 20,
                        text: c.displayName,
                        isTitle: true,
                        textColor: AppColors.greyHintLight,
                        screenHeight: 300.sp,
                        textAlign: TextAlign.right,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    CustomTitleText(
                      text: "مكان الاقامة",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: MediaQuery.of(context).size.height * .65,
                      horizontalPadding:
                          MediaQuery.of(context).size.height * .025,
                    ),

                    const SizedBox(height: 6),
                    Obx(() => Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonFormField<String>(
                            value:
                                c.syGovernorates.contains(c.governorate.value)
                                    ? c.governorate.value
                                    : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            hint: CustomTitleText(
                              horizontalPadding: 10,
                              text:controller.governorate.value,
                              isTitle: true,
                              textColor: AppColors.greyHintLight,
                              screenHeight: 300.sp,
                              textAlign: TextAlign.right,
                            ),
                            dropdownColor: Get.isDarkMode
                                ? const Color(0xFF2C2C2C)
                                : Colors.white,
                            items: c.syGovernorates
                                .map((g) => DropdownMenuItem(
                                      value: g,
                                      child: Text(g,
                                          textDirection: TextDirection.rtl),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) c.governorate.value = val;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: colors.greyInput_greyInputDark,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: colors.primary_cyen),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: AppColors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: AppColors.red),
                              ),
                            ),
                          ),
                        )),

                    SizedBox(height: 8.h),

                    // البريد الإلكتروني (عرض فقط)
                    CustomTitleText(
                      text: "البريد الالكتروني",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: MediaQuery.of(context).size.height * .65,
                      horizontalPadding:
                          MediaQuery.of(context).size.height * .025,
                    ),
                    const SizedBox(height: 6),
                    CustomBackgroundWithWidget(
                      height: 50.h,
                      width: double.infinity,
                      color: colors.greyInput_greyInputDark,
                      borderRadius: 30,
                      alignment: Alignment.centerRight,
                      child: CustomTitleText(
                        horizontalPadding: 20,
                        text: c.displayEmail,
                        isTitle: true,
                        textColor: AppColors.greyHintLight,
                        screenHeight: 300.sp,
                        textAlign: TextAlign.right,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // الهاتف + تاريخ الميلاد (قابلان للتعديل)
                    Row(
                      children: [
                        Expanded(
                          child: FormFieldLabelAndInput(
                            isNumber: false,
                            validator: (val) {},
                            label: "رقم الهاتف",
                            hint: "ادخل رقم الهاتف الخاص بك...",
                            icon: Icons.phone_android,
                            myController: c.phoneNum,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Expanded(
                        //   child: FormFieldLabelAndInput(
                        //     isNumber: false,
                        //     validator: (val) {},
                        //     label: "تاريخ الميلاد",
                        //     hint: "--/--/--",
                        //     icon: Icons.calendar_month,
                        //     myController: c.birthDate,

                        //   ),
                        // ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => c.pickBirthDate(context),
                            child: AbsorbPointer(
                              child: FormFieldLabelAndInput(
                                isNumber: false,
                                validator: (val) {},
                                label: "تاريخ الميلاد",
                                hint: "dd/MM/yyyy",
                                icon: Icons.calendar_month,
                                myController: c.birthDate,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // التخصص (قابل للتعديل)
                    CustomTitleText(
                      text: "التخصص",
                      isTitle: true,
                      textAlign: TextAlign.right,
                      textColor: colors.titleText,
                      screenHeight: MediaQuery.of(context).size.height * .65,
                      horizontalPadding:
                          MediaQuery.of(context).size.height * .025,
                    ),
                    // لو لديك Widget جاهز:
                    SpecificatSelectorAtProfile(),
                    SizedBox(height: 16.h),

                    // زر حفظ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint(controller.governorate.value);
                            debugPrint(controller.birthDate.text);
                            debugPrint(controller.phoneNum.text);
                            debugPrint(controller.specification.text);
                            controller.updateProfileInfo();
                          },
                          child: CustomBackgroundWithWidget(
                            height: 35.h,
                            width: 100.w,
                            color: colors.primary_cyen,
                            borderRadius: 10,
                            child: CustomTitleText(
                              text: "حفظ",
                              isTitle: true,
                              textColor: colors.white_textDark,
                              screenHeight: 350.sp,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({
    super.key,
    required this.isDark,
    required this.onChanged,
    this.width = 56,
    this.height = 28,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final thumbSize = height - 4; // مع حواف داخلية 2 + 2

    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: width,
        height: height,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                  size: thumbSize * 0.55,
                  color: isDark ? Colors.black87 : Colors.amber[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SpecificatSelectorAtProfile extends StatelessWidget {
  const SpecificatSelectorAtProfile({super.key});

  static const Map<String, String> specMap = {
    "باك ايند": "backend",
    "فرونت موبايل": "front_mobile",
    "فرونت ويب": "front_Web", 
  };

  static const Map<String, String> reverseSpecMap = {
    "backend": "باك ايند",
    "front_mobile": "فرونت موبايل",
    "front_Web": "فرونت ويب",
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileControllerImp>();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildSpecButton("باك ايند", controller, context),
          SizedBox(width: 16.w),
          buildSpecButton("فرونت موبايل", controller, context),
          SizedBox(width: 16.w),
          buildSpecButton("فرونت ويب", controller, context),
        ],
      );
    });
  }

  Widget buildSpecButton(
      String title, ProfileControllerImp controller, BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final isSelected = controller.selectedSpecification.value == title;
    final valueToStore = specMap[title]; // كود السيرفر

    return OutlinedButton(
      onPressed: () {
        controller.selectedSpecification.value = title;
        controller.specification.text = valueToStore ?? "";
        debugPrint("UI label: ${controller.selectedSpecification.value}");
        debugPrint("server value to send: ${controller.specification.text}");
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? colors.cyenToWhite_greyInputDark : Colors.transparent,
        side: isSelected
            ? BorderSide(width: 2, color: colors.greyInput_greyInputDark)
            : BorderSide(
                color: colors.greyHint_authTabUnselectedText, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? colors.primary_cyen
              : colors.greyHint_authTabUnselectedText,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
