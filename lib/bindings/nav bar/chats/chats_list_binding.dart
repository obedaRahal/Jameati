import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';

class ChatsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsListControllerImp>(
        () => ChatsListControllerImp());
  }
}