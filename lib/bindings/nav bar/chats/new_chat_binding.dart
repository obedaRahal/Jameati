import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/new_chat_controller.dart';

class NewChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewChatControllerImp>(
        () => NewChatControllerImp());
  }
}