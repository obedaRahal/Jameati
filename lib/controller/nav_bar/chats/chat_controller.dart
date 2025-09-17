import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/services/pusher/pusher_service.dart';
import 'package:project_manag_ite/data/datasource/remote/chats/chat_data.dart';
import 'package:project_manag_ite/data/model/chats/chat_model.dart';

abstract class ChatController extends GetxController {}

class ChatControllerImp extends GetxController {
  final writeMessage = TextEditingController();

  StatusRequest statusRequest = StatusRequest.none;
  int? conversationId;
  String? peerName;
  ConversationDetails? details;

  final RxList<Messages> messagesList = <Messages>[].obs;

  // لمنع التكرار
  final Set<int> _seenMessageIds = <int>{};

  final scrollController = ScrollController();
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final Rx<String?> nextBeforeId = Rx<String?>(null);
  static const int pageSize = 30;
  DateTime? _lastLoadMoreAt;

  final ChatData chatData = ChatData(Get.find());
  final listChatController = Get.find<ChatsListControllerImp>();

  PusherChannel? pusherChannel;
  int? currentUserId; // لضبط is_mine

  //===========================
  // تهيئة المعرّف الحالي للمستخدم
  Future<void> _ensureCurrentUserId() async {
    if (currentUserId != null) return;
    try {
      final sp = await SharedPreferences.getInstance();
      currentUserId = sp.getInt('user_id'); // غيّر المفتاح حسب مشروعك
    } catch (_) {}
  }

  //===========================
  // Scroll listener للتحميل التراكمي
  bool onScrollNotification(ScrollNotification n) {
    if (n.metrics.axis != Axis.vertical) return false;
    final atTop = n.metrics.atEdge &&
        (n.metrics.pixels >= n.metrics.maxScrollExtent - 0.5);
    if ((n is ScrollEndNotification || n is UserScrollNotification) && atTop) {
      loadMoreOlder();
    }
    if (n is OverscrollNotification && atTop && n.overscroll > 0) {
      loadMoreOlder();
    }
    return false;
  }

  //===========================
  // جلب الصفحة الأولى (الأحدث)
  Future<void> getAllMessageAtChat() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await chatData.postToGetAllMessageAtChat(conversationId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        final parsed = ChatModel.fromJson(response);
        details = parsed.conversationDetails;
        peerName ??= details?.peer?.name;

        final fetched = parsed.messages ?? <Messages>[];
        final newestFirst = fetched.reversed.toList();
        messagesList.assignAll(newestFirst);

        _seenMessageIds
          ..clear()
          ..addAll(newestFirst.map((m) => m.id).whereType<int>());

        final nb = parsed.nextBeforeId;
        nextBeforeId.value = nb;
        hasMore.value = (nb != null) || (fetched.length == pageSize);
      } catch (_) {
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  //===========================
  // تحميل أقدم
  Future<void> loadMoreOlder() async {
    if (isLoadingMore.value) return;
    if (!hasMore.value) return;
    if (conversationId == null) return;
    if (messagesList.isEmpty) return;
    if (!scrollController.hasClients) return;

    final beforeId = nextBeforeId.value;
    if (beforeId == null) {
      hasMore.value = false;
      return;
    }

    final now = DateTime.now();
    if (_lastLoadMoreAt != null &&
        now.difference(_lastLoadMoreAt!) < const Duration(milliseconds: 400)) {
      return;
    }
    _lastLoadMoreAt = now;

    isLoadingMore.value = true;

    try {
      final beforeMax = scrollController.position.maxScrollExtent;
      final beforePix = scrollController.position.pixels;

      final response = await chatData.postToGetAllMessageAtChat(
        conversationId,
        beforeId: beforeId,
      );

      final st = handlingData(response);
      if (st == StatusRequest.success) {
        final parsed = ChatModel.fromJson(response);
        final fetched = parsed.messages ?? <Messages>[];

        if (fetched.isEmpty) {
          hasMore.value = false;
          nextBeforeId.value = null;
          debugPrint('📥 server page empty, next=${parsed.nextBeforeId}');
        } else {
          final older = fetched.reversed.toList();
          final List<Messages> newOnes = <Messages>[];
          for (final m in older) {
            final mid = m.id;
            if (mid != null && !_seenMessageIds.contains(mid)) {
              newOnes.add(m);
            }
          }

          if (newOnes.isEmpty) {
            hasMore.value = false;
            nextBeforeId.value = parsed.nextBeforeId;
          } else {
            messagesList.addAll(newOnes);
            _seenMessageIds.addAll(newOnes.map((e) => e.id!).toSet());
            final nb = parsed.nextBeforeId;
            nextBeforeId.value = nb;
            hasMore.value = (nb != null) || (fetched.length == pageSize);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!scrollController.hasClients) return;
              final afterMax = scrollController.position.maxScrollExtent;
              final delta = afterMax - beforeMax;
              final target = (beforePix + delta - 1)
                  .clamp(0.0, scrollController.position.maxScrollExtent);
              scrollController.jumpTo(target);
            });
          }
        }
      }
    } catch (_) {
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> sendMessage(String msg) async {
    try {
      statusRequest = StatusRequest.loading;
      update(["sendMessages"]);

      // (اختياري) مرّر X-Socket-Id
      // final socketId = await Get.find<PusherService>().getSocketId();

      final response = await chatData.postToSendMessage(
        conversationId ?? 0, msg, "text",
        // socketId: socketId,
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final code = response["statusCode"] as int? ?? 200;
        if (code == 200 || code == 201) {
          // لو ما استُقبل الحدث خلال 1.5 ثانية، اجلب مرّة واحدة
          Future.delayed(const Duration(milliseconds: 1500), () {
            // لو ما تغيّر آخر id محليًا، اعمل refresh
            // (احفظ آخر id قبل الإرسال إن حبيت تتحقق)
            getAllMessageAtChat();
          });

          // حدِّث قائمة المحادثات وامسح الحقل
          Get.find<ChatsListControllerImp>().getAllConversation();
          writeMessage.clear();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    } finally {
      update(["sendMessages"]);
    }
  }

  //===========================
  // تطبيع payload القادمة من Pusher
Map<String, dynamic> _normalizeMessagePayload(
  Map<String, dynamic> raw,
) {
  Map<String, dynamic> m = raw;
  if (m['payload'] is Map) m = Map<String, dynamic>.from(m['payload']);
  if (m['message'] is Map) m = Map<String, dynamic>.from(m['message']);

  final id       = m['id'] ?? m['message_id'] ?? m['msg_id'] ?? m['uuid'] ?? m['mid'];
  final senderId = m['sender_id'] ?? m['from_id'] ?? m['senderId'] ?? m['user_id'];
  final type     = m['type'] ?? m['message_type'] ?? 'text';
  final content  = m['content'] ?? m['body'] ?? m['text'] ?? m['message'] ?? '';
  final attach   = m['attachment_path'] ?? m['attachmentPath'] ?? (m['attachment'] is Map ? m['attachment']['path'] : null);
  final time     = m['messageTime'] ?? m['created_at'] ?? m['createdAt'];

  // ⚠️ النقطة المهمة: استخدم peer.id للفصل
  final peerId = details?.peer?.id;
  final bool isMineCalc = (senderId != null)
      ? (peerId != null ? senderId != peerId : false) // لو peerId معروف: أي sender != peer هو أنا
      : false;                                         // (الـ bot عادة sender_id=null ⇒ ليس لي)

  return {
    'id'             : id,
    'sender_id'      : senderId,
    'faq_id'         : m['faq_id'],
    'message_type'   : type,
    'content'        : content,
    'attachment_path': attach,
    'status'         : m['status'],
    'is_mine'        : isMineCalc,
    'messageTime'    : time ?? DateTime.now().toIso8601String(),
  };
}


void _handleEventData(dynamic data) {
  try {
    final dataStr = data is String ? data : jsonEncode(data);
    final any = jsonDecode(dataStr);
    final Map<String, dynamic> raw =
        any is Map<String, dynamic> ? any : {'content': any?.toString() ?? ''};

    final mapped = _normalizeMessagePayload(raw); // 👈 بدون currentUserId
    final msg = Messages.fromJson(mapped);
    final mid = msg.id;
    if (mid == null) return;

    if (_seenMessageIds.add(mid)) {
      messagesList.insert(0, msg);
    } else {
      final idx = messagesList.indexWhere((m) => m.id == mid);
      if (idx != -1) messagesList[idx] = msg;
    }
  } catch (e, st) {
    debugPrint('❌ pusher parse error: $e\n$st\npayload=$data');
  }
}





  Future<void> _subscribeRealtime(int convId) async {
    final pusher = Get.find<PusherService>();
    await pusher.ready();

    await pusher.subscribeConversationIfNeeded(
      convId,
      onEvent: (event) {
        String? name;
        dynamic data;

        if (event is PusherEvent) {
          name = event.eventName;
          data = event.data;
        } else if (event is Map) {
          name = (event['eventName'] ?? event['event'])?.toString();
          data = event['data'];
        } else if (event is String) {
          try {
            final m = jsonDecode(event) as Map<String, dynamic>;
            name = (m['eventName'] ?? m['event'])?.toString();
            data = m['data'];
          } catch (_) {
            return;
          }
        } else {
          return;
        }

        debugPrint('🔥 event: $name on conv=$convId');

        if (name != null) {
          final lower = name.toLowerCase();
          if (lower == 'message.created' ||
              lower == 'bot.replied' ||
              lower.contains('message')) {
            _handleEventData(data);
          }
        }
      },
      onSubscriptionSucceeded: (_) => debugPrint('✅ joined conv=$convId'),
      onSubscriptionError: (err) =>
          debugPrint('❌ join error conv=$convId: $err'),
    );
  }






  int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  return int.tryParse(v.toString());
}





  //===========================
  // دورة حياة الكنترولر
  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    conversationId = args?['conversationId'] as int?;
    peerName = args?['peerName'] as String?;

    _ensureCurrentUserId().then((_) {
      if (conversationId != null) {
        getAllMessageAtChat();
        _subscribeRealtime(conversationId!);
      }
    });
  }

    @override
  void onClose() {
    scrollController.dispose();
    writeMessage.dispose();
    if (conversationId != null) {
      Get.find<PusherService>().unsubscribeConversationSafe(conversationId!);
    }
    super.onClose();
  }
}
