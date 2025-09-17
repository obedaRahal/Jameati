import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/search_controller.dart';

class SearchScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchControllerImp>(() => SearchControllerImp());
  }
}
