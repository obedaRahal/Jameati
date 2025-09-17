import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/core/services/push%20notifications/local_notification_services.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static MyServices get _prefs => Get.find<MyServices>();

  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log(token ?? 'null');

    log('FCM token: ${token ?? 'null'}');
    if (token != null && token.isNotEmpty) {
      await _prefs.sharedPreferences.setString('fcm_token', token);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // background handler
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);

    // افتتح التطبيق من إشعار كان مُستلم وهو مغلق
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      refreshHomeBadge(); // ⬅️ حدّث العداد
    }

    // الضغط على الإشعار وفتح التطبيق
    FirebaseMessaging.onMessageOpenedApp.listen((_) {
      refreshHomeBadge(); // ⬅️ حدّث العداد
    });

    // foreground message
    handlebackfoorgroundMessage();
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    //طباعة معلومات الرسالة
    log(message.notification?.title ?? "no title");
    log(message.notification?.body ?? "no thinggg");

    // ⬅️ علّم أننا نحتاج تحديث العداد عند استئناف التطبيق
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('needsBadgeRefresh', true);
  }

  static void handlebackfoorgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // if (Get.context != null) {
      //   // التطبيق مفتوح: إشعار داخل التطبيق فقط
      showInAppNotification(
        message.notification?.title ?? 'إشعار',
        message.notification?.body ?? '',
      );
      // } else {
      // التطبيق في الخلفية أو لا يوجد سياق: إشعار نظام
      //LocalNotificationService.showBasicNotification(message);
      //}
      // ⬅️ حدّث العداد مباشرة في الـ foreground
      refreshHomeBadge();
    });
  }

  static void refreshHomeBadge() {
    if (Get.isRegistered<HomeControllerImp>()) {
      Get.find<HomeControllerImp>().getNotificationCount();
    }
  }
}
