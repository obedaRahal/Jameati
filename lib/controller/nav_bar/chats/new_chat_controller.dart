import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/chats/new_chat_data.dart';
import 'package:project_manag_ite/data/model/chats/show_user_to_start_chat_model.dart';

abstract class NewChatController extends GetxController {}

class NewChatControllerImp extends NewChatController {
  RxString selectedChatFilter = "مشرفين".obs;
  final Rx<int?> selectedMemberId = Rx<int?>(null);

  final RxList<UserNewChatModel> doctorList = <UserNewChatModel>[].obs;
  final RxList<UserNewChatModel> myGroupList = <UserNewChatModel>[].obs;
  final RxList<UserNewChatModel> studentList = <UserNewChatModel>[].obs;

  List<UserNewChatModel> get filteredUsers {
    switch (selectedChatFilter.value) {
      case "مشرفين":
        return doctorList;
      case "غروبي":
        return myGroupList;
      default:
        return studentList;
    }
  }

  NewChatData newChatData = NewChatData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  ShowUserToStartChatmodel? showUserToStartChatmodel;

  Future<void> getListOfNewImgAdvCurrentYear() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await newChatData.getListsOUsers();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = ShowUserToStartChatmodel.fromJson(response);

          doctorList.assignAll(parsed.doctors ?? []);
          myGroupList.assignAll(parsed.myGroup ?? []);
          studentList.assignAll(parsed.students ?? []);

          debugPrint(
              "✅ تم الجلب: d=${doctorList.length} g=${myGroupList.length} s=${studentList.length}");
        } catch (e) {
          debugPrint("❌ parsing error: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        statusRequest = StatusRequest.failure;
      } else {
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  void selectMember(int id) => selectedMemberId.value = id;

  final chatListController = Get.find<ChatsListControllerImp>();
  createNewConversation(int memberId) async {
    debugPrint("$memberId");
    statusRequest = StatusRequest.loading;
    update(["createConversation"]);

    var response = await newChatData.getToCreateNewConversation(memberId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at getToCreateNewConversation: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل ناجح - code $code');
        chatListController.getAllConversation();

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        Get.toNamed(AppRoute.chatsList);
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    } else {
      debugPrint("❌ Request failed with status: $statusRequest");
      showCustomSnackbar(
        title: "فشل في الاتصال",
        message: "تحقق من اتصالك بالإنترنت أو أعد المحاولة",
        isSuccess: false,
      );
    }

    update(["createConversation"]);
  }

  @override
  void onInit() {
    getListOfNewImgAdvCurrentYear();
    super.onInit();
  }
}
