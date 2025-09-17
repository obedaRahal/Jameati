import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';

class MyGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyGroupControllerImp>(() => MyGroupControllerImp());
  }
}
