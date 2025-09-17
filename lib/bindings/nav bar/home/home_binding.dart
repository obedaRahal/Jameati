import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeControllerImp>(
        () => HomeControllerImp());
  }
}