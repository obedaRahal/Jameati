import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    
  }

}