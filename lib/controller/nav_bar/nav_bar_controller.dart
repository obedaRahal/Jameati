import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/group/join_to_group_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/group/my_group_controller.dart'; // لو عندك كونترولر للمجموعة
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/search_controller.dart';
import 'package:project_manag_ite/core/services/services.dart'; // يحتوي MyServices
import 'package:project_manag_ite/view/screen/nav bar/chats/chats_list_screen.dart';
import 'package:project_manag_ite/view/screen/nav bar/groups/join_to_group_screen.dart';
import 'package:project_manag_ite/view/screen/nav bar/groups/my_group_screen.dart';
import 'package:project_manag_ite/view/screen/nav bar/home/home_screen.dart';
import 'package:project_manag_ite/view/screen/nav bar/search_screen.dart';

abstract class NavBarController extends GetxController {
  changePage(int currentPage);
}

class NavBarControllerImpl extends NavBarController {
  final MyServices _services = Get.find<MyServices>();

  final RxBool isInGroup = false.obs;

  int currentPage = 0;
  late List<Widget> listPage;

  @override
  void onInit() {
    super.onInit();
    isInGroup.value = _services.sharedPreferences.getBool("is_in_group") ?? false;
    _buildPages();

    ever<bool>(isInGroup, (_) {
      _buildPages();
      update();
    });
  }

  void _buildPages() {
    listPage = [
      const HomeScreen(),
      const ChatsListScreen(),
      isInGroup.value ? const MyGroupScreen() : const JoinToGroupScreen(),
      const SearchScreen(),
    ];
  }

  void setIsInGroup(bool v) {
    _services.sharedPreferences.setBool("is_in_group", v);
    isInGroup.value = v;
  }

  @override
  changePage(int i) {
    switch (currentPage) {
      case 0:
        if (Get.isRegistered<HomeControllerImp>()) Get.delete<HomeControllerImp>();
        break;
      case 1:
        if (Get.isRegistered<ChatsListControllerImp>()) Get.delete<ChatsListControllerImp>();
        break;
      case 2:
        // قد يكون صفحة المجموعة أو الانضمام — احذف الموجود بأمان
        if (Get.isRegistered<MyGroupControllerImp>()) Get.delete<MyGroupControllerImp>();
        if (Get.isRegistered<JoinToGroupControllerImp>()) Get.delete<JoinToGroupControllerImp>();
        break;
      case 3:
        if (Get.isRegistered<SearchControllerImp>()) Get.delete<SearchControllerImp>();
        break;
    }

    currentPage = i;
    update();
  }
}
