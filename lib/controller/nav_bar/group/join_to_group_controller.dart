import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/group/join%20to%20group/join_to_group_data.dart';
import 'package:project_manag_ite/data/model/groups/join%20to%20group/join_to_group_item_model.dart';

abstract class JoinToGroupController extends GetxController {
  getListOfGroupToJoin();
  askToJoin(int idGroup);
}

class JoinToGroupControllerImp extends JoinToGroupController {
  late TextEditingController searchForGroup;

  StatusRequest statusRequest = StatusRequest.none;
  JoinToGroupItemModel? joinToGroupItemModel;
  JoinToGroupData joinToGroupData = JoinToGroupData(Get.find());

  List<Groups> groups = [];

  @override
  getListOfGroupToJoin() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await joinToGroupData.getGroupList();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = JoinToGroupItemModel.fromJson(response);

          groups = parsed.groups ?? [];
          debugPrint("✅ تم جلب بيانات الجروبات بنجاح: ${groups.length} جروب");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  @override
  askToJoin(int idGroup) async {
    debugPrint("$idGroup");
    statusRequest = StatusRequest.loading;
    update();

    var response = await joinToGroupData.askToJoin(idGroup);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at askToJoin: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل ناجح - code $code');

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        getListOfGroupToJoin();
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

    update();
  }




  cancelToJoin(int idGroup) async {
    debugPrint("$idGroup");
    statusRequest = StatusRequest.loading;
    update();

    var response = await joinToGroupData.cancelToJoin(idGroup);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at cancelToJoin: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل ناجح - code $code');

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        getListOfGroupToJoin();
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

    update();
  }

  @override
  void onInit() {
    searchForGroup = TextEditingController();
    getListOfGroupToJoin();
    super.onInit();
  }

  @override
  void dispose() {
    searchForGroup.dispose();
    super.dispose();
  }
}
