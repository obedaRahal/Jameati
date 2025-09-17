import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/nav_bar_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/data/datasource/remote/invitations/invitation_data.dart';
import 'package:project_manag_ite/data/model/home/invitations/invitation_model.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

abstract class InvitationCintroller extends GetxController {}

class InvitationCintrollerImp extends InvitationCintroller {
  StatusRequest statusRequest = StatusRequest.none;
  final InvitationData invitationData = InvitationData(Get.find());

  final List<Invitations> invitationList = [];

  Future<void> getListOfInvitations({bool silent = false}) async {
    if (!silent) {
      statusRequest = StatusRequest.loading;
      update(["invites"]);
    }

    final response = await invitationData.getListOfInvitation();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        final parsed = InvitationModel.fromJson(response);
        invitationList
          ..clear()
          ..addAll(parsed.invitations ?? []);
        // debug
        debugPrint("✅ invitations: ${invitationList.length}");
      } catch (e) {
        statusRequest = StatusRequest.failure;
      }
    }

    update(["invites"]);
  }

  void _seedDummyInvitations() {
    invitationList
      ..clear()
      ..addAll([
        Invitations(
          id: 101,
          groupId: 1,
          invitedUserId: 33,
          invitedByUserId: 12,
          status: "pending",
          group: Group(
            id: 1,
            name: "فريق النخبة",
            specialityNeeded: [
              "backend",
              "front_web",
            ],
            image: null, // أو رابط صورة إن رغبت
          ),
        ),
        Invitations(
          id: 102,
          groupId: 2,
          invitedUserId: 33,
          invitedByUserId: 14,
          status: "accepted",
          group: Group(
            id: 2,
            name: "أبطال الموبايل",
            specialityNeeded: ["front_mobile"],
            image: null,
          ),
        ),
        Invitations(
          id: 103,
          groupId: 3,
          invitedUserId: 33,
          invitedByUserId: 15,
          status: "rejected",
          group: Group(
            id: 3,
            name: "مشروع الويب الحديث",
            specialityNeeded: ["front_web", "backend"],
            image: null,
          ),
        ),
        Invitations(
          id: 104,
          groupId: 4,
          invitedUserId: 33,
          invitedByUserId: 11,
          status: "pending",
          group: Group(
            id: 4,
            name: "Data Wizards",
            specialityNeeded: ["backend"],
            image: null,
          ),
        ),
      ]);

    // تحدّيث الـ UI
    statusRequest = StatusRequest.success;
    update(["invites"]);
  }

  MyServices myServices = Get.find();

  acceptInvitation(int invitationId) async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at acceptInvitation  is $statusRequest");
    update();
    var response = await invitationData.postToAcceptInvitation(invitationId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at acceptInvitation: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        myServices.sharedPreferences.setBool("is_in_group", true);
        debugPrint(
            "is_in_group isssssss ${myServices.sharedPreferences.getBool("is_in_group")}");

        getListOfInvitations();
        Get.delete<NavBarControllerImpl>();
        Get.offAndToNamed(AppRoute.navBar);
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
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
    }

    update();
  }

  rejectInvitation(int invId) async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at rejectInvitation  is $statusRequest");
    update();
    var response = await invitationData.postToRejectInvitation(invId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at rejectInvitation: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        getListOfInvitations();
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
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
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getListOfInvitations();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   if (kDebugMode) {
  //     _seedDummyInvitations(); // ← جرّب الواجهة فورًا
  //   } else {
  //     getListOfInvitations();
  //   }
  // }
}
