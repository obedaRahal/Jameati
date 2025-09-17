import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/form%201%20+%202/submit_idea_controller.dart';

class SubmitIdeaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitIdeaControllerImp>(
        () => SubmitIdeaControllerImp());
  }
}