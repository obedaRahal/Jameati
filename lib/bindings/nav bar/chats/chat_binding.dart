import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatControllerImp>(
        () => ChatControllerImp());
  }
}