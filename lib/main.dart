import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/bindings/initial_binding.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/services/push%20notifications/local_notification_services.dart';
import 'package:project_manag_ite/core/services/push%20notifications/push_notification_service.dart';
import 'package:project_manag_ite/core/services/pusher/pusher_service.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/firebase_options.dart';
import 'package:project_manag_ite/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initialServices();

  FirebaseMessaging.onBackgroundMessage(
      PushNotificationsService.handlebackgroundMessage);
  await Future.wait([
    PushNotificationsService.init(),
    LocalNotificationService.init(),
  ]);

  // عند الضغط على الإشعار المحلي (من LocalNotificationService)
  LocalNotificationService.streamController.stream.listen((_) {
    PushNotificationsService.refreshHomeBadge(); // ⬅️
  });

// عند استئناف التطبيق من الخلفية: إن كان وصلك إشعار بالخلفية، حدّث العداد
  SystemChannels.lifecycle.setMessageHandler((String? state) async {
    if (state == AppLifecycleState.resumed.toString()) {
      final prefs = await SharedPreferences.getInstance();
      final needs = prefs.getBool('needsBadgeRefresh') ?? false;
      if (needs) {
        await prefs.remove('needsBadgeRefresh');
        PushNotificationsService.refreshHomeBadge();
      }
    }
    return null;
  });

  await Get.putAsync<PusherService>(() async => await PusherService().init());

  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = Get.find<ThemeController>().theme.value;
      return ScreenUtilInit(
        designSize: Size(393, 873),
        //Size(390, 880),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Project Management',
            theme: theme,
            getPages: routes,
            initialBinding: InitialBindings(),
          );
        },
      );
    });
  }
}
