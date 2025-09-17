import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/data/datasource/static/static.dart';

abstract class OnBoardingController extends GetxController {
  next();
  skip();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController {
  late PageController pageController = PageController();

  int currentPage = 0;

  MyServices myServices= Get.find();

  @override
  next() {
    currentPage++;

    if (currentPage > onBoardingList.length - 1) {
      debugPrint('great than 3333333   $currentPage');
      myServices.sharedPreferences.setString("onboarding", "1");
      Get.offAllNamed(AppRoute.welccm);
    } else {
      debugPrint('great than 3333333 and currentpage is $currentPage');

      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

   @override
  skip() {
    Get.offAllNamed(AppRoute.welccm);
    debugPrint("skip method at onboarding cont");
  }


  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
