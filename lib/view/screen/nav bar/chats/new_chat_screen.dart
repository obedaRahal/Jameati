import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/new_chat_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/group/my%20group/bottom%20sheet/show_member_bottom_sheet.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';
import 'package:project_manag_ite/view/widget/search/filter_button.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final List<String> chatFilters = ["مشرفين", "غروبي", "طلاب"];
    final controller = Get.find<NewChatControllerImp>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () {
          debugPrint("تم انشاء محادثة");
          //Get.back();
          debugPrint("${controller.selectedMemberId.value}");
          controller.createNewConversation(controller.selectedMemberId.value ?? 0);
        },
        child: Container(
          height: 50.w,
          width: 50.w,
          decoration: BoxDecoration(
            color: colors.primary_cyen,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: colors.primary_cyen,
              width: 3,
            ),
          ),
          child: Icon(
            Icons.check_sharp,
            color: AppColors.white,
            size: 37.h,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 18.h, right: 18.h, top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios,
                        color: colors.titleText, size: 30),
                  ),
                  const Spacer(),
                  CustomTitleText(
                    text: "بدء محادثة",
                    isTitle: true,
                    screenHeight: 800.sp,
                    textColor: colors.titleText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // أزرار الفلاتر
              Obx(() => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: chatFilters.map((filter) {
                          final selected =
                              controller.selectedChatFilter.value == filter;
                          return FilterButton(
                            text: filter,
                            isSelected: selected,
                            onTap: () {
                              controller.selectedChatFilter.value = filter;
                              controller.selectedMemberId.value =
                                  null; // امسح التحديد عند تغيير الفلتر
                              debugPrint("تم اختيار : $filter");
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )),

              Divider(color: colors.greyInput_greyInputDark, thickness: 2),

              SizedBox(height: 8.h),
              Expanded(
                child: GetBuilder<NewChatControllerImp>(
                  builder: (c) {
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (c.statusRequest != StatusRequest.success) {
                      return Center(
                        child: CustomTitleText(
                          text: "لا يوجد مستخدمين لعرضهم",
                          isTitle: true,
                          screenHeight: 400.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    // ✅ اعتمد Obx هنا ليعيد البناء عند تغيير الفلتر أو عند وصول بيانات RxList
                    return Obx(() {
                      final items = c.filteredUsers; // List<UserNewChatModel>
                      if (items.isEmpty) {
                        return Center(
                          child: Text("لا يوجد نتائج",
                              style: TextStyle(
                                  color: colors.titleText, fontSize: 16.sp)),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => Divider(
                          color: colors.greyInput_greyInputDark,
                          thickness: 1,
                          endIndent: 40.w,
                          indent: 40.w,
                        ),
                        itemBuilder: (_, i) {
                          final u = items[i];
                          final id = u.id ?? -1;
                          final avatar = u.profileImage;

                          // هذا Obx لتمييز العضو المحدد
                          return Obx(() {
                            final isSelected = c.selectedMemberId.value == id;
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: MemberTile(
                                name: u.name ?? "",
                                id: id,
                                avatarPath:
                                    avatar, // ممكن يكون URL أو Asset نسبي
                                colors: colors,
                                isSelected: isSelected,
                                onTap: () {
                                  if (id != -1) c.selectMember(id);
                                  debugPrint(
                                      "selected id: ${c.selectedMemberId.value}");
                                },
                              ),
                            );
                          });
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
