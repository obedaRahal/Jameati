import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/chats/chats_list_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/group/join_to_group_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/home/home_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/nav_bar_controller.dart';
import 'package:project_manag_ite/controller/nav_bar/search_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/data/datasource/remote/group/create%20group/create_group_data.dart';
import 'package:project_manag_ite/data/model/groups/create%20group/invite_people_to_join_model.dart';

abstract class CreateNewGroupController extends GetxController {
  getListOfStudentToInvite();
  createGroup();
}

class CreateNewGroupControllerImp extends CreateNewGroupController {
  RxInt selectedTab = 0.obs; 

  late TextEditingController groupName;
  late TextEditingController groupDescription;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  RxList<String> selectedSpecialities = <String>[].obs;

  void toggleSpeciality(String title) {
    if (selectedSpecialities.contains(title)) {
      selectedSpecialities.remove(title);
    } else {
      selectedSpecialities.add(title);
    }
  }

  final Map<String, List<String>> skillsBySpeciality = {
    "Backend": ["asp", "spring", "nestjs", "django", "laravel"],
    "front_mobile": [
      "ionic",
      "xamarin",
      "swift",
      "flutter",
    ],
    "front_web": ["react", "vue", "angular", "svelte", "next-js"],
  };

  RxList<String> selectedFrameworkNeededSkills = <String>[].obs;

  RxBool isBackEndOn = true.obs;
  RxBool isFrontEndMobOn = true.obs;
  RxBool isFrontEndWebOn = true.obs;

  RxString privateOrPublic = "".obs;

  Rx<File?> pickedImage = Rx<File?>(null);

  StatusRequest statusRequest = StatusRequest.none;
  CreateGroupData createGroupData = CreateGroupData(Get.find());
  InvitePeopleToJoinModel? invitePeopleToJoinModel;
  List<StudentsModel> students = [];

  RxList<int> invitationsId = <int>[].obs;

  @override
  getListOfStudentToInvite() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await createGroupData.getStudentList();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = InvitePeopleToJoinModel.fromJson(response);

          students = parsed.students ?? [];
          debugPrint("✅ تم جلب بيانات الجروبات بنجاح: ${students.length} جروب");
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

  MyServices myServices = Get.find();

  @override
  createGroup() async {
    if (selectedSpecialities.length != selectedFrameworkNeededSkills.length) {
      showCustomSnackbar(
        title: "لم تتم عملية الانشاء",
        message: "يجب ان يكون عدد المهارات المطلوبة يساوي عدد الاختصاص المطلوب",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at login controller is $statusRequest");
    update();
    var response = await createGroupData.postToCreateGroup(
      name: groupName.text,
      description: groupDescription.text,
      specialityNeeded: selectedSpecialities,
      frameworkNeeded: selectedFrameworkNeededSkills,
      image: pickedImage.value,
      type: privateOrPublic.value, // ✅
      invitations: invitationsId,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at login: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('انشاء غروب دخول ناجح - code $code');
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: true,
        );
        myServices.sharedPreferences.setBool("is_in_group", true);
        Get.delete<JoinToGroupControllerImp>(force: true);
        Get.delete<CreateNewGroupControllerImp>(force: true);
        Get.delete<SearchControllerImp>(force: true);
        Get.delete<HomeControllerImp>(force: true);
        Get.delete<ChatsListControllerImp>(force: true);
        Get.delete<NavBarControllerImpl>(force: true);
        Get.offAndToNamed(AppRoute.navBar);
        return;
      }

      if (response.containsKey("title") && response.containsKey("body")) {
        debugPrint("⚠️ نجاح فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
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
    groupName = TextEditingController();
    groupDescription = TextEditingController();

    getListOfStudentToInvite();
    super.onInit();
  }

  @override
  void dispose() {
    groupName.dispose();
    groupDescription.dispose();
    super.dispose();
  }
}
