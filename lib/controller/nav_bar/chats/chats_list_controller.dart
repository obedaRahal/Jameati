import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/data/datasource/remote/chats/chat_list_data.dart';
import 'package:project_manag_ite/data/model/chats/list_of_all_conversation_model.dart';

abstract class ChatsListController extends GetxController {}

class ChatsListControllerImp extends ChatsListController {
  late TextEditingController searchForOne;

  StatusRequest statusRequest = StatusRequest.none;

  final RxList<ListOfAllConversationModel> allConversationList = <ListOfAllConversationModel>[].obs;

  final ChatListData chatListData = ChatListData(Get.find());

  Timer? _debounce;
  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      update(["chats"]);
    });
  }

  static String _normalize(String? s) {
    if (s == null) return '';
    var t = s.toLowerCase();

    const diacritics = ['\u064B','\u064C','\u064D','\u064E','\u064F','\u0650','\u0651','\u0652','\u0670'];
    for (final d in diacritics) { t = t.replaceAll(d, ''); }

    t = t.replaceAll(RegExp(r'[آأإٱ]'), 'ا');
    t = t.replaceAll('ى', 'ي');
    t = t.replaceAll('ة', 'ه');
    t = t.replaceAll(RegExp(r'\s+'), ' ').trim();

    const arabicIndic   = '٠١٢٣٤٥٦٧٨٩';
    const easternArabic = '۰۱۲۳۴۵۶۷۸۹';
    for (int i = 0; i < 10; i++) {
      t = t.replaceAll(arabicIndic[i], String.fromCharCode(48 + i));
      t = t.replaceAll(easternArabic[i], String.fromCharCode(48 + i));
    }
    return t;
  }

  List<ListOfAllConversationModel> get filteredList {
    final q = _normalize(searchForOne.text);
    final source = allConversationList.toList();

    if (q.isEmpty) return source;

    return source.where((c) {
      final name = _normalize(c.peer?.name ?? c.title ?? '');
      final last = _normalize(c.lastMessage ?? '');
      return name.contains(q) || last.contains(q);
    }).toList();
  }

  Future<void> getAllConversation() async {
    statusRequest = StatusRequest.loading;
    update(["chats"]);

    final response = await chatListData.getAllConversation();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        final List items = (response['data'] as List?) ?? [];
        final parsed = items
            .map((e) => ListOfAllConversationModel.fromJson(e as Map<String, dynamic>))
            .toList();

        allConversationList.assignAll(parsed);
      } catch (e) {
        debugPrint("❌ parsing error: $e");
        statusRequest = StatusRequest.failure;
      }
    }

    update(["chats"]);
  }

  void clearSearch() {
    searchForOne.clear();
    update(["chats"]);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // String? resolveAvatar(String? path) {
  //   final s = path?.trim();
  //   if (s == null || s.isEmpty) return null;
  //   if (s.startsWith('http')) return s;
  //   final base = GetPlatform.isAndroid ? 'http://10.0.2.2' : 'http://localhost';
  //   return '$base$s';
  // }

  @override
  void onInit() {
    super.onInit();
    searchForOne = TextEditingController();
    searchForOne.addListener(_onQueryChanged);
    getAllConversation();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchForOne.removeListener(_onQueryChanged);
    searchForOne.dispose();
    super.dispose();
  }
}
