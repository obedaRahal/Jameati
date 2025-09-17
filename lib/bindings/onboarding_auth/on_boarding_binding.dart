import 'package:get/get.dart';
import 'package:project_manag_ite/controller/onboarding/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingControllerImp>(() => OnBoardingControllerImp());
  }
}