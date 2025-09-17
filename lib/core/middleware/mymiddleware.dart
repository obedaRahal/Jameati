import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/services/services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  // ignore: body_might_complete_normally_nullable
  RouteSettings? redirect(String? route) {
    // if (myServices.sharedPreferences.getString("login") == "2") {
    //   return const RouteSettings(name:AppRoute.navBar );
    // }

    if (myServices.sharedPreferences.getString("onboarding") == "1") {
      //return const RouteSettings(name:AppRoute.welccm );
      return const RouteSettings(name: AppRoute.welccm);
    }
  }
}
