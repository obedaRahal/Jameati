import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/group/create_new_group_controller.dart';

class CreateNewGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewGroupControllerImp>(() => CreateNewGroupControllerImp());
  }
}
