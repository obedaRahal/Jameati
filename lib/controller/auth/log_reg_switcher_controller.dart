import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/login_controller.dart';
import 'package:project_manag_ite/controller/auth/register_controller.dart';

abstract class LoginRegisterSwitcherController extends GetxController {
  void switchPage(int index);
  void goToLogin();
  void goToRegister();
}

class LoginRegisterSwitcherControllerImp
    extends LoginRegisterSwitcherController {
  var currentIndex = 0.obs;
  late PageController pageController;

  @override
  void switchPage(int index) async {
    await Future.delayed(const Duration(milliseconds: 20));
    currentIndex.value = index;

    if (index == 0) {
      if (Get.isRegistered<RegisterControllerImp>()) {
        Get.delete<RegisterControllerImp>();
      }
      if (!Get.isRegistered<LoginControllerImp>()) {
        Get.put(LoginControllerImp());
      }
    } else if (index == 1) {
      if (Get.isRegistered<LoginControllerImp>()) {
        Get.delete<LoginControllerImp>();
      }
      if (!Get.isRegistered<RegisterControllerImp>()) {
        Get.put(RegisterControllerImp());
      }
    }
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    super.onInit();
  }

  @override
  void goToLogin() async {
    switchPage(0);
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  @override
  void goToRegister() async {
    switchPage(1);
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  @override
void onClose() {
  // حذف كونترولرات تسجيل الدخول وإنشاء الحساب إن وُجدت
  if (Get.isRegistered<LoginControllerImp>()) {
    Get.delete<LoginControllerImp>();
  }

  if (Get.isRegistered<RegisterControllerImp>()) {
    Get.delete<RegisterControllerImp>();
  }

  pageController.dispose();
  super.onClose();
}

}
