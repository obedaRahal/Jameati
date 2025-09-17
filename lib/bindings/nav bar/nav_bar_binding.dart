import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/group/join_to_group_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/nav_bar_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/search_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarControllerImpl>(() => NavBarControllerImpl());

    Get.lazyPut<HomeControllerImp>(() => HomeControllerImp(), fenix: true);
    Get.lazyPut<ChatsListControllerImp>(() => ChatsListControllerImp(), fenix: true);
    Get.lazyPut<JoinToGroupControllerImp>(() => JoinToGroupControllerImp(), fenix: true);
    Get.lazyPut<SearchControllerImp>(() => SearchControllerImp(), fenix: true);
    Get.lazyPut<MyGroupControllerImp>(() => MyGroupControllerImp(), fenix: true);
  }
}
