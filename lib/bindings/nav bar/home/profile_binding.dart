import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileControllerImp>(
        () => ProfileControllerImp());
  }
}