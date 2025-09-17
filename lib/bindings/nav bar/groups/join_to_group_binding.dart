import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/join_to_group_controller.dart';

class JoinToGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinToGroupControllerImp>(() => JoinToGroupControllerImp());
  }
}
