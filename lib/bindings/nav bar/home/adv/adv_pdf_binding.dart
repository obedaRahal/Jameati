import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/adv/adv_pdf_controller.dart';

class AdvPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvPdfControllerImp>(
        () => AdvPdfControllerImp());
  }
}