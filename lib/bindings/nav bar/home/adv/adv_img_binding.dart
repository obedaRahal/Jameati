import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/adv/adv_img_controller.dart';

class AdvImgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvImgControllerImp>(
        () => AdvImgControllerImp());
  }
}