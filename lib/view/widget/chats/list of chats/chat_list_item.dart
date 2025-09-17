import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/data/model/chats/list_of_all_conversation_model.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class ChatListItemApi extends StatelessWidget {
  final ListOfAllConversationModel conv;
  final VoidCallback? onTap;
  const ChatListItemApi({super.key, required this.conv, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final name = conv.peer?.name ?? conv.title ?? 'بدون اسم';
    final lastMessage = conv.lastMessage ?? '';
    final unread = conv.unreadCount ?? 0;
    final time = _formatTime(conv.lastMessageAt);
    final imageUrl = conv.peer?.profileImage;

    return InkWell(
      onTap: onTap,
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(50),
                  //   child: Image.asset(
                  //     imageUrl ?? MyImageAsset.obeda,
                  //     height: 60.h,
                  //     width: 60.h,
                  //     fit: BoxFit.cover,
                  //   ),
                  //       // ),
                  //       Container(
                  //   padding: EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: AppColors.greyHintDark),
                  //     borderRadius: BorderRadius.circular(50)
                  //   ),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(30.r),
                  //     child: SizedBox(
                  //       height: 50.h, width: 50.h,
                  //       child: _buildAvatar(avatarPath),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyHintDark),
                        borderRadius: BorderRadius.circular(50)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(imageUrl ?? "",
                          height: 50.h,
                          width: 50.h,
                          errorBuilder: (_, __, ___) =>
                              SvgPicture.asset(MyImageAsset.profileNoPic,
                                  height: 55.h,
                                  //width: 50.h,
                                  fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTitleText(
                          text: name,
                          isTitle: true,
                          screenHeight: 550.sp,
                          textColor: colors.titleText,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                        ),
                        if (lastMessage != "")
                          CustomTitleText(
                            text: lastMessage,
                            isTitle: false,
                            screenHeight: 600.sp,
                            textColor: AppColors.greyHintLight,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                          ),
                        if (lastMessage == "")
                          CustomTitleText(
                            text: "انقر لإجراء محادثة",
                            isTitle: false,
                            screenHeight: 600.sp,
                            textColor: AppColors.greyHintLight,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                          ),
                      ],
                    ),
                  ),

                  /// ✅ الوقت + العداد
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10.h),
                      if (unread > 0)
                        CustomBackgroundWithWidget(
                          height: 30.h,
                          width: 28.w,
                          color: AppColors.red,
                          borderRadius: 30,
                          child: CustomTitleText(
                            text: unread.toString(),
                            isTitle: true,
                            screenHeight: 370.sp,
                            textColor: AppColors.white,
                            // themeController.isDark
                            //     ? AppColors.black
                            //     : AppColors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      // if (unread == 0)
                      //   SizedBox(
                      //     height: 30.h,
                      //   ),
                      CustomTitleText(
                        text: time,
                        isTitle: false,
                        screenHeight: 700.sp,
                        textColor: AppColors.greyHintLight,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
      ),
    );
  }

  String _formatTime(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final d = DateTime(dt.year, dt.month, dt.day);
      final diff = d.difference(today).inDays;
      if (diff == 0) {
        // hh:mm a -> 05:34 م
        return DateFormat('hh:mm a', 'ar').format(dt);
      } else if (diff == -1) {
        return 'أمس';
      } else {
        return DateFormat('dd/MM/yyyy', 'ar').format(dt);
      }
    } catch (_) {
      return iso!;
    }
  }
}
