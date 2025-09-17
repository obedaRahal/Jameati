// services/pusher_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Env {
  static const apiBase = 'http://192.168.155.44'; // 
  static const pusherKey = '60211dc77a5393171c15';
  static const pusherCluster = 'mt1';
}

class _TokenStore {
  // 👈 هذا هو توكن المستخدم الذي تستخدمه مع الـ API
  static const _k = 'token'; // أو access_token لو مشروعك يسميه هكذا
  static Future<String?> get() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_k);
  }
}

class PusherService extends GetxService {
  final _pusher = PusherChannelsFlutter.getInstance();
  bool _inited = false;

  // تتبع حالة الاشتراكات لتفادي التكرار
  final Set<String> _subs = <String>{};
  final Set<String> _subscribing = <String>{};

  Future<PusherService> init() async {
    if (_inited) return this;

    await _pusher.init(
      apiKey: Env.pusherKey,
      cluster: Env.pusherCluster,
      useTLS: true,
      onConnectionStateChange: (current, previous) {
        debugPrint('🔌 Pusher state: $previous -> $current');
        // لا تعِد الاشتراك يدويًا هنا — المكتبة تتكفّل بذلك.
      },
      onError: (message, code, exception) {
        debugPrint('❌ Pusher error: $message ($code) $exception');
      },
      onAuthorizer: (String channelName, String socketId, _) async {
  final token = await _TokenStore.get();
  debugPrint('🔑 token is ${token == null ? 'NULL' : 'present'} for $channelName');

  final res = await http.post(
    Uri.parse('${Env.apiBase}/broadcasting/auth'),
    headers: {
      'Authorization': 'Bearer ${token ?? ''}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({'channel_name': channelName, 'socket_id': socketId}),
  );

  debugPrint('🔐 AUTH ${res.statusCode} for $channelName: ${res.body}');
  if (res.statusCode >= 200 && res.statusCode < 300) {
    return jsonDecode(res.body);
  }
  throw Exception('Auth failed (${res.statusCode}): ${res.body}');
},

    );

    _inited = true;
    return this;
  }

  Future<void> ready() async {
    await init();
    await _pusher.connect();
  }

  String _nameForConv(int conversationId) => 'private-conversation.$conversationId';

  // ✅ اشتراك آمن ضد التكرار
  Future<PusherChannel?> subscribeConversationIfNeeded(
    int conversationId, {
    void Function(dynamic)? onEvent,
    void Function(dynamic)? onSubscriptionSucceeded,
    void Function(dynamic)? onSubscriptionError,
  }) async {
    final name = _nameForConv(conversationId);

    if (_subs.contains(name)) {
      debugPrint('🔁 already subscribed: $name (skip)');
      return null;
    }
    if (_subscribing.contains(name)) {
      debugPrint('⏳ subscribing in progress: $name (skip)');
      return null;
    }

    _subscribing.add(name);
    try {
      debugPrint('➡️ subscribe $name');
      final ch = await _pusher.subscribe(
        channelName: name,
        onEvent: onEvent,
        onSubscriptionSucceeded: (data) {
  _subs.add(name);
  debugPrint('✅ Subscribed $name');
  onSubscriptionSucceeded?.call(data);
},
onSubscriptionError: (err) {
  debugPrint('❌ Subscribe error on $name: $err');
  onSubscriptionError?.call(err);
},

      );
      return ch;
    } on PlatformException catch (e) {
      // في حالة hot restart قد يرمي هذا الاستثناء؛ نتجاهله بأمان
      if ((e.message ?? '').contains('Already subscribed')) {
        debugPrint('ℹ️ Already subscribed reported by platform for $name — ignoring');
        _subs.add(name); // اعتبره مشترك
        return null;
      }
      rethrow;
    } finally {
      _subscribing.remove(name);
    }
  }

  Future<void> unsubscribeConversationSafe(int conversationId) async {
    final name = _nameForConv(conversationId);
    if (_subs.contains(name)) {
      debugPrint('⬅️ unsubscribe $name');
      _subs.remove(name);
      try {
        await _pusher.unsubscribe(channelName: name);
      } catch (e) {
        debugPrint('⚠️ unsubscribe error for $name: $e');
      }
    } else {
      debugPrint('ℹ️ skip unsubscribe (not subscribed): $name');
    }
  }

  // (اختياري) لإعادة تهيئة الاتصال بعد Hot Restart لو احتجت
  Future<void> resetConnection() async {
    try { await _pusher.disconnect(); } catch (_) {}
    _subs.clear();
    _subscribing.clear();
    await _pusher.connect();
  }

  Future<String?> getSocketId() async {
    try { return await _pusher.getSocketId(); } catch (_) { return null; }
  }
}
