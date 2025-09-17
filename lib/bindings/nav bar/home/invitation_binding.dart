import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/invitation_controller.dart';

class InvitationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvitationCintrollerImp>(
        () => InvitationCintrollerImp());
  }
}