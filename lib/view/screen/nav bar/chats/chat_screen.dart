import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chat_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/chats/chat_model.dart';
import 'package:project_manag_ite/view/widget/chats/list%20of%20chats/search_bar_with_clear_widget.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<ChatControllerImp>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(
              imageAppBArr: controller.details?.peer?.profileImage ?? "",
              colors: colors,
              title: controller.peerName ?? "محادثة مع شخص اخر",
            ),
            Divider(color: colors.greyInput_greyInputDark, thickness: 2),
            Expanded(
              child: GetBuilder<ChatControllerImp>(
                builder: (c) {
                  if (c.statusRequest == StatusRequest.loading) {
                    return const Center(child: Text(""));
                  }
                  if (c.statusRequest == StatusRequest.failure ||
                      c.statusRequest == StatusRequest.serverfaliure) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("تعذر جلب الرسائل"),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: c.getAllMessageAtChat,
                            child: const Text("إعادة المحاولة"),
                          ),
                        ],
                      ),
                    );
                  }

                  // // ✅ نجاح: استخدم Obx فقط للرسائل (RxList)
                  // return Obx(() {
                  //   final msgs = c.messagesList; // لمس Rx هنا مهم
                  //   if (msgs.isEmpty) {
                  //     return _EmptyChatView(colors: colors, details: c.details);
                  //   }
                  //   return ListView.builder(
                  //     reverse: true,
                  //     padding: EdgeInsets.symmetric(horizontal: 18.h),
                  //     itemCount: msgs.length,
                  //     itemBuilder: (_, i) {
                  //       final m = msgs[i];
                  //       final mine = m.isMine == true;
                  //       return _MessageBubble(
                  //         text: m.content ?? "",
                  //         msgTime: m.messageTime,
                  //         isMine: mine,
                  //         colors: colors,
                  //       );
                  //     },
                  //   );
                  // });

                  return Obx(() {
                    final msgs = c.messagesList;
                    final showTopExtra =
                        c.hasMore.value || c.isLoadingMore.value;
                    final itemCount = msgs.length +
                        (showTopExtra || !c.hasMore.value ? 1 : 0);

                    if (msgs.isEmpty) {
                      return _EmptyChatView(colors: colors, details: c.details);
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: c.onScrollNotification,
                      child: ListView.builder(
                          controller: c.scrollController,
                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 18.h),
                          itemCount: itemCount,
                          itemBuilder: (_, i) {
                            final noMore =
                                !c.hasMore.value && !c.isLoadingMore.value;
                            final isSentinel =
                                i == msgs.length && (showTopExtra || noMore);

                            if (isSentinel) {
                              if (c.hasMore.value && !c.isLoadingMore.value) {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => c.loadMoreOlder());
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Center(
                                  child: c.isLoadingMore.value
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2))
                                      : const Text("لا مزيد من الرسائل"),
                                ),
                              );
                            }

                            final m = msgs[i];
                            return _MessageBubble(
                              text: m.content ?? "",
                              msgTime: m.messageTime,
                              isMine: m.isMine  ??true,
                              colors: colors,
                              isBot: m.faqId ?? 0,
                            );
                          }),
                    );
                  });
                },
              ),
            ),

            // إدخال وإرسال
            Padding(
              padding: EdgeInsets.all(18.h),
              child: Row(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint(
                            "send msg and msg is    ${controller.writeMessage.text} and conv id is ${controller.conversationId}");
                        controller.sendMessage(controller.writeMessage.text);
                      },
                      child: CustomBackgroundWithWidget(
                        borderRadius: 30,
                        color: colors.primary_cyen,
                        height: 50.h,
                        width: 50.h,
                        child: Icon(Icons.send_rounded,
                            color: AppColors.white, size: 26.h),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SearchBarWithClear(
                      actionWidget: const SizedBox.shrink(),
                      hintTextAtSearchBar: "مراسلة",
                      controller: controller.writeMessage,
                      iconData: FontAwesomeIcons.penToSquare,
                      onClear: () => controller.writeMessage.clear(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final CustomAppColors colors;
  final String title;
  final String imageAppBArr;
  const _AppBar(
      {required this.colors, required this.title, required this.imageAppBArr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, left: 18.h, right: 18.h),
      child: Row(
        children: [
          // InkWell(
          //   onTap: () => debugPrint("profile"),
          //   child: Icon(Icons.info_outline_rounded,
          //       color: colors.titleText, size: 35.h),
          // ),
          const Spacer(),
          CustomTitleText(
            text: title,
            isTitle: true,
            screenHeight: 600.sp,
            textColor: colors.titleText,
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 6.w),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: Image.asset(MyImageAsset.obeda, height: 40.w, width: 40.w),
          // ),

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(imageAppBArr,
                height: 40,
                errorBuilder: (_, __, ___) => SvgPicture.asset(
                    MyImageAsset.profileNoPic,
                    height: 40.w,
                    width: 40.w,
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: 3.w),
          InkWell(
            onTap: () {
              final listChatController = Get.find<ChatsListControllerImp>();
              debugPrint("get all convbvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
              listChatController.getAllConversation();
              Get.back();
            },
            child: Icon(Icons.arrow_forward_ios,
                color: colors.titleText, size: 30.h),
          ),
        ],
      ),
    );
  }
}

// class _EmptyChatView extends StatelessWidget {
//   final CustomAppColors colors;
//   final ConversationDetails? details;
//   const _EmptyChatView({required this.colors, this.details});

//   @override
//   Widget build(BuildContext context) {
//     final name = details?.peer?.name ?? "";
//     final profileUrl = details?.peer?.profileImage;
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.w),
//           child: Container(
//             decoration: BoxDecoration(
//               color: colors.cyenToWhite_greyInputDark,
//               border: Border.all(color: colors.primary_cyen, width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   CustomTitleText(
//                     text: "عزيزي الطالب ",
//                     isTitle: true,
//                     screenHeight: 600.sp,
//                     textColor: colors.primary_cyen,
//                     textAlign: TextAlign.center,
//                   ),
//                   CustomTitleText(
//                     text:
//                         "سيقوم المجيب الآلي الخاص بالدكتور بالرد على أسئلتك، وفي حال لم يتم الرد سيتم إرسال الرسالة للدكتور.",
//                     isTitle: false,
//                     screenHeight: 650.sp,
//                     textColor: colors.greyHint_authTabUnselectedText,
//                     textAlign: TextAlign.end,
//                   ),
//                   SizedBox(height: 6.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const Spacer(),

//         ClipRRect(
//           borderRadius: BorderRadius.circular(100),
//           child: Image.asset(profileUrl.toString(),
//               height: 150.h,
//               errorBuilder: (_, __, ___) => SvgPicture.asset(
//                   MyImageAsset.profileNoPic,
//                   height: 150.h,
//                   width: 150.h,
//                   fit: BoxFit.cover)),
//         ),
//         CustomTitleText(
//           text: name,
//           isTitle: true,
//           screenHeight: 700.sp,
//           textColor: colors.titleText,
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 16.h),
//         // FilterButton(
//         //   text: "عرض الملف الشخصي",
//         //   isSelected: true,
//         //   onTap: () => debugPrint("تم اختيار عرض الملف الشخصي"),
//         // ),
//         const Spacer(),
//       ],
//     );
//   }
// }



class _EmptyChatView extends StatelessWidget {
  final CustomAppColors colors;
  final ConversationDetails? details;
  const _EmptyChatView({required this.colors, this.details});

  @override
  Widget build(BuildContext context) {
    final name = details?.peer?.name ?? "";
    final profileUrl = details?.peer?.profileImage;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 12.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight( // يجعل العمود يشغل أقل ارتفاع ممكن ثم يتمدّد لو لزم
              child: Column(
                mainAxisSize: MainAxisSize.max, // مهم مع IntrinsicHeight
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colors.cyenToWhite_greyInputDark,
                      border: Border.all(color: colors.primary_cyen, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTitleText(
                            text: "عزيزي الطالب ",
                            isTitle: true,
                            screenHeight: 600.sp,
                            textColor: colors.primary_cyen,
                            textAlign: TextAlign.center,
                          ),
                          CustomTitleText(
                            text:
                                "سيقوم المجيب الآلي الخاص بالدكتور بالرد على أسئلتك، وفي حال لم يتم الرد سيتم إرسال الرسالة للدكتور.",
                            isTitle: false,
                            screenHeight: 650.sp,
                            textColor: colors.greyHint_authTabUnselectedText,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // صورة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      (profileUrl ?? "").isEmpty ? MyImageAsset.profileNoPic : profileUrl!,
                      height: 150.h,
                      errorBuilder: (_, __, ___) => SvgPicture.asset(
                        MyImageAsset.profileNoPic,
                        height: 150.h,
                        width: 150.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  // الاسم
                  CustomTitleText(
                    text: name,
                    isTitle: true,
                    screenHeight: 700.sp,
                    textColor: colors.titleText,
                    textAlign: TextAlign.center,
                  ),

                  // مسافة مرنة بسيطة بدل Spacer صلب
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}




class _MessageBubble extends StatelessWidget {
  final String text;
  final String? msgTime; // بصيغة dd/MM/yyyy
  final bool isMine;
  final int? isBot;
  final CustomAppColors colors;

  const _MessageBubble({
    required this.text,
    required this.isMine,
    required this.colors,
    this.msgTime,
    this.isBot,
  });

  @override
  Widget build(BuildContext context) {
    final align = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Stack(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 320),
                padding: EdgeInsets.only(
                    top: 5.h, left: 12.h, right: 12.h, bottom: 20.h),
                decoration: BoxDecoration(
                  color: isMine ? AppColors.primary : AppColors.greyHintDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(text,
                    style: TextStyle(color: AppColors.white, fontSize: 19.sp)),
              ),
              Positioned(
                bottom: 0,
                left: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, right: 8.0, left: 8.0),
                  child: Text(
                    msgTime!,
                    style: TextStyle(fontSize: 15.sp, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
          // if (isMine==false  && isBot != null)
          //   Row(
          //     children: [
          //       Icon(
          //         Icons.auto_stories_outlined,
          //         color: AppColors.greyHintDark,
          //         size: 16.h,
          //       ),
          //       SizedBox(
          //         width: 4.w,
          //       ),
          //       Text(
          //         "تم الرد من قبل المجيب الآلي",
          //         style:
          //             TextStyle(fontSize: 10.sp, color: AppColors.greyHintDark),
          //       ),
          //       SizedBox(
          //         width: 4.w,
          //       ),
          //       Icon(
          //         Icons.auto_stories_outlined,
          //         color: AppColors.greyHintDark,
          //         size: 16.h,
          //       ),
          //     ],
          //   )
        ],
      ),
    );
  }
}
