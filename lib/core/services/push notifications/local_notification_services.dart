import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
    // هنا يمكنك تنفيذ أي تنقل أو منطق عند الضغط على الإشعار
  }

  static Future init() async {
    // 1. إعداد Android
    //change the image icon
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 2. إعداد iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // 3. تهيئة الطرفين
    final  InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // ✅ 4. إنشاء قناة إشعارات Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel', // 👈 المعرف الفريد للقناة
      'Default Notifications', // 👈 الاسم الظاهر للمستخدم
      description: 'This channel is used for default notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // ✅ 5. تهيئة النظام بالإعدادات والقناة
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  // image from network عرض إشعار بسيط
  // static void showBasicNotification(RemoteMessage message) async {
  //   final http.Response image = await http
  //       .get(Uri.parse(message.notification?.android?.imageUrl ?? ""));
  //   BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(
  //           ByteArrayAndroidBitmap.fromBase64String(
  //               base64Encode(image.bodyBytes)),
  //           largeIcon: ByteArrayAndroidBitmap.fromBase64String(
  //               base64Encode(image.bodyBytes)));
  //   AndroidNotificationDetails android = AndroidNotificationDetails(
  //     'default_channel', // ✅ نفس معرف القناة
  //     'Default Notifications',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     styleInformation: bigPictureStyleInformation,
  //   );
  //   NotificationDetails details = NotificationDetails(
  //     android: android,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title ?? 'بدون عنوان',
  //     message.notification?.body ?? 'بدون محتوى',
  //     details,
  //   );
  // }

  static Future<void> showBasicNotification(RemoteMessage message) async {
    // تحميل الصورة من الأصول كـ ByteData
    final ByteData byteData = await rootBundle.load('assets/icons/feather.jpg');
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    final BigPictureStyleInformation bigPictureStyle =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap(imageBytes),
      largeIcon: ByteArrayAndroidBitmap(imageBytes),
      contentTitle: message.notification?.title ?? 'بدون عنوان',
      summaryText: message.notification?.body ?? 'بدون محتوى',
    );

    final AndroidNotificationDetails android = AndroidNotificationDetails(
        'default_channel', 'Default Notifications',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigPictureStyle,
        playSound: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher'
        //icon: 'feather',
        //icon: 'feather_notification_icon',
        );

    // final android = AndroidNotificationDetails(
    //   'default_channel',
    //   'Default Notifications',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   icon: '@mipmap/ic_launcher',
    //   styleInformation: BigTextStyleInformation(
    //     message.notification?.body ?? '',
    //     contentTitle: '<b>${message.notification?.title ?? 'إشعار جديد'}</b>',
    //     //summaryText: '📢 إشعار من التطبيق',
    //     htmlFormatContentTitle: true,
    //     htmlFormatBigText: true,
    //     htmlFormatSummaryText: true,
    //   ),
    //   color: AppColors.primary, // لون أيقونة التنبيه
    //   playSound: true,
    //   enableVibration: true,
    // );

    final NotificationDetails details = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'بدون عنوان',
      message.notification?.body ?? 'بدون محتوى',
      details,
    );
  }
}

void showInAppNotification(String title, String body) {
  final isDark = Get.isDarkMode;

  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(16),
    backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
    borderRadius: 12,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 12,
        spreadRadius: 2,
        offset: const Offset(0, 0),
      ),
    ],
    titleText: const SizedBox.shrink(),
    messageText: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ✅ أيقونة ثابتة الحجم
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/icons/feather.jpg',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12), // مسافة بين الأيقونة والنصوص

        // ✅ النصوص - تأخذ المساحة المتبقية
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 4),
  );
}
