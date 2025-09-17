import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/view/widget/chats/list%20of%20chats/chat_list_item.dart';
import 'package:project_manag_ite/view/widget/chats/list%20of%20chats/search_bar_with_clear_widget.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<ChatsListControllerImp>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: InkWell(
        onTap: () => Get.toNamed(AppRoute.newChatScreen),
        child: Container(
          height: 50, width: 50,
          decoration: BoxDecoration(
            color: colors.primary_cyen,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colors.primary_cyen, width: 3),
          ),
          child: const Center(child: FaIcon(FontAwesomeIcons.comments, color: AppColors.white)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(
                text: "الرسائل", isTitle: true, screenHeight: 800, textColor: colors.titleText, textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // شريط البحث
              SearchBarWithClear(
                actionWidget: GestureDetector(
                  onTap: controller.clearSearch,
                  child: const CustomTitleText(
                    text: "إلغاء", isTitle: true, screenHeight: 550, textAlign: TextAlign.center, textColor: AppColors.red,
                  ),
                ),
                hintTextAtSearchBar: "البحث عن محادثة",
                controller: controller.searchForOne,
                onClear: controller.clearSearch,
              ),

              const SizedBox(height: 16),

              // قائمة المحادثات
              Expanded(
                child: GetBuilder<ChatsListControllerImp>(
                  id: "chats",
                  builder: (c) {
                    if (c.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (c.statusRequest != StatusRequest.success) {
                      return Center(
                        child: Text("تعذر جلب المحادثات", style: TextStyle(color: colors.titleText)),
                      );
                    }

                    final list = c.filteredList;
                    if (list.isEmpty) {
                      return Center(
                        child: Text("لا توجد محادثات", style: TextStyle(color: colors.titleText)),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        final conv = list[i];
                        return ChatListItemApi(
                          conv: conv,
                          onTap: () {
                            Get.toNamed(
                              AppRoute.chatScreen,
                              arguments: {
                                'conversationId': conv.conversationId,
                                'peerName': conv.peer?.name,
                              },
                            );
                            debugPrint("conversation id: ${conv.conversationId}, name: ${conv.peer?.name}");
                          },
                        );
                      },
                    );
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
