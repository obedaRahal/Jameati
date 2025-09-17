import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/groups/create%20group/invite_people_to_join_model.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class InvitePeopleToCreateGroup extends StatelessWidget {
  const InvitePeopleToCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<CreateNewGroupControllerImp>();

    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: GetBuilder<CreateNewGroupControllerImp>(
              builder: (controller) {
                return ListView.builder(
                  padding:
                      EdgeInsets.only(top: 16.h, bottom: 80.h), 
                  itemCount: controller.students.length,
                  itemBuilder: (context, index) {
                    final student = controller.students[index];
                    return InvitePeopleToJoinMyGroupListItem(
                      student: student,
                      onRequestJoin: () {
                        debugPrint("🟢 دعوة: ${student.name}");
                        debugPrint("🟢 student id: ${student.id}");
                        // controller.inviteStudent(student.id);
                      },
                    );
                  },
                );
              },
            ),
          ),

          /// ✅
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: InkWell(
              onTap: () {
                debugPrint("✅ تأكيد الدعوات");
                // controller.sendInvites();
                debugPrint(controller.groupName.text);
                debugPrint(controller.groupDescription.text);
                debugPrint(controller.pickedImage.toString());
                debugPrint(controller.selectedSpecialities.toList().toString());
                debugPrint(controller.selectedFrameworkNeededSkills.toList().toString());
                debugPrint(controller.privateOrPublic.toString());
                debugPrint(controller.invitationsId.toList().toString());
                controller.createGroup();

              },
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: colors.primary_cyen,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvitePeopleToJoinMyGroupListItem extends StatelessWidget {
  final StudentsModel student;
  final VoidCallback onRequestJoin;

  const InvitePeopleToJoinMyGroupListItem({
    super.key,
    required this.student,
    required this.onRequestJoin,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(border: Border.all( color: AppColors.greyInputDark) ,borderRadius: BorderRadius.circular(30) ,),
                    child: Image.network(
                      student.profileImage ?? "",
                      height: 60.h,
                      width: 60.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          MyImageAsset.profileNoPic,
                          height: 50.h,
                          width: 50.w,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
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
                            text: student.name ?? "",
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: CustomBackgroundWithWidget(
                              height: 22.h,
                              width: 90.w,
                              color: colors.cyenToWhite_greyInputDark,
                              borderRadius: 5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: CustomTitleText(
                                  text: student.studentSpeciality ?? "",
                                  //"# ${student.studentSpeciality}",
                                  isTitle: false,
                                  screenHeight: 600.sp,
                                  textColor: colors.primary_cyen,
                                  textAlign: TextAlign.right,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomBackgroundWithWidget(
                      height: 26.h,
                      width: 75.w,
                      color: colors.greyBackgrondHome_darkPrimary,
                      borderRadius: 15,
                      child: Center(
                        child: Text(
                          student.studentStatus ?? "الحالة",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: colors.titleText,
                            fontFamily: MyFonts.hekaya,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(() {
                      final controller =
                          Get.find<CreateNewGroupControllerImp>();
                      final isInvited =
                          controller.invitationsId.contains(student.id);

                      return CustomBackgroundWithWidget(
                        height: 26.h,
                        width: 85.w,
                        color: isInvited
                            ? AppColors.greyBackgrondHome
                            : colors.primary_cyen,
                        borderRadius: 15,
                        child: InkWell(
                          onTap: () {
                            if (isInvited) {
                              controller.invitationsId.remove(student.id);
                            } else {
                              controller.invitationsId
                                  .add(student.id!); // تأكد أنه غير null
                            }
                          },
                          child: Center(
                            child: Text(
                              isInvited ? "الغاء الدعوة" : "دعوة انضمام",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: isInvited
                                    ? AppColors.greyHintDark
                                    : colors.backgroundWhite,
                                fontFamily: MyFonts.hekaya,
                              ),
                            ),
                          ),
                        ),
                      );
                    })

                    // CustomBackgroundWithWidget(
                    //   height: 26.h,
                    //   width: 85.w,
                    //   color: colors.primary_cyen,
                    //   borderRadius: 15,
                    //   child: InkWell(
                    //     onTap: onRequestJoin,
                    //     child: Center(
                    //       child: Text(
                    //         "دعوة انضمام",
                    //         style: TextStyle(
                    //           fontSize: 16.sp,
                    //           color: colors.backgroundWhite,
                    //           fontFamily: MyFonts.hekaya,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Divider(
              color: colors.greyInput_greyInputDark,
              thickness: 2,
              endIndent: 40.w,
              indent: 40.w,
            ),
          ],
        ),
      ),
    );
  }
}

