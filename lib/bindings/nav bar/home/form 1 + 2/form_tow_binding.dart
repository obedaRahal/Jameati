import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/form%201%20+%202/form_tow_controller.dart';

class FormTowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormTowControllerImp>(
        () => FormTowControllerImp());
  }
}