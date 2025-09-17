import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/data/datasource/remote/group/my%20group/mygroup_data.dart';
import 'package:project_manag_ite/data/model/form%20one/doctor_for_formone_model.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/info_of_project_model.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/my_group_info_model.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/mygroup_public_deatils_model.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/show_join_request_model.dart';
import 'package:project_manag_ite/data/model/groups/my%20group/show_member_to_change_leader.dart';

abstract class MyGroupController extends GetxController {}

class MyGroupControllerImp extends MyGroupController {
  RxString selectedScreenPart = "عام".obs;
  final List<String> screenPart = ["عام", "مشروع", "معلومات الغروب"];

  //part 33333333333333333333333
  late TextEditingController groupDescription;
  late TextEditingController groupName;
  Rx<File?> pickedImage = Rx<File?>(null);
  String? groupImageUrl; // رابط الصورة من السيرفر

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
    //"UI/UX": ["figma", "adobe-xd", "photoshop"],
  };
  RxList<String> selectedFrameworkNeededSkills = <String>[].obs;

  RxBool isBackEndOn = true.obs;
  RxBool isFrontEndMobOn = true.obs;
  RxBool isFrontEndWebOn = true.obs;

  RxString privateOrPublic = "".obs;

  StatusRequest statusRequest = StatusRequest.none;

  MyGroupInfoModel? myGroupInfoModel;

  void getMyGroupInfo() async {
    statusRequest = StatusRequest.loading;
    update(["infoGroup"]);

    var response = await myGroupData.getMyGroupInfo();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        debugPrint("im attttttttttttttt getMyGroupInfo()(((())))");
        var data = response['data'];

        groupName.text = data['name'] ?? "";
        groupDescription.text = data['description'] ?? "";

        groupImageUrl = data['image'];
        pickedImage.value = null;

        selectedSpecialities.clear();
        if (data['speciality_needed'] != null) {
          selectedSpecialities.addAll(
            List<String>.from(data['speciality_needed']),
          );
        }

        selectedFrameworkNeededSkills.clear();
        if (data['framework_needed'] != null) {
          selectedFrameworkNeededSkills.addAll(
            List<String>.from(data['framework_needed']),
          );
        }

        privateOrPublic.value = data['type'] ?? "public";
      } catch (e) {
        debugPrint("im attttttttttttttt getMyGroupInfo()(((())))");
        debugPrint("❌ Parse error in getMyGroupInfo: $e");
      }
    }

    update(["infoGroup"]);
  }

  updateGroupInfo() async {
    if (groupId == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "المجموعة غير معروفة بعد. حاول إعادة فتح الصفحة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at updateGroupInfo is $statusRequest");
    update(["infoGroup"]);
    var response = await myGroupData.updateGroupInfo(
        name: groupName.text,
        description: groupDescription.text,
        specialityNeeded: selectedSpecialities,
        frameworkNeeded: selectedFrameworkNeededSkills,
        image: pickedImage.value,
        type: privateOrPublic.value, 
        groupId: groupId!);

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at updateGroupInfo: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint(' updateGroupInfo ناجح - code $code');
        statusRequest = StatusRequest.success;
        getMyGroupInfo();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: true,
        );
        update(["infoGroup"]);
        return;
      } else if (response.containsKey("title") &&
          response.containsKey("body") &&
          response["statusCode"] != 200) {
        debugPrint("⚠️ نجاح فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: false,
        );
        getMyGroupInfo();
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

    update(["infoGroup"]);
  }

  // part 222222222222222222
  ShowJoinRequestModel? showJoinRequestModel;
  MyGroupData myGroupData = MyGroupData(Get.find());
  List<Requests> requests = [];
  int? groupId;

  getListOfStudentToJoinMyGroup() async {
    if (groupId == null) {
      debugPrint('⛔ getListOfStudentToJoinMyGroup called without groupId');
      return;
    }

    statusRequest = StatusRequest.loading;
    update(["joinRequests"]);

    final response = await myGroupData.getJoinRequestList(groupId!);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = ShowJoinRequestModel.fromJson(response);

          requests = parsed.requests ?? [];
          debugPrint(
              "✅getListOfStudentToJoinMyGroup تم جلب بيانات  بنجاح: ${requests.length} ");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint(
            "⚠️getListOfStudentToJoinMyGroup خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update(["joinRequests"]);
  }

  acceptJoinRequestToMyGroup(int userIdToAcceptJoin) async {
    statusRequest = StatusRequest.loading;
    debugPrint(
        "\\\\\\\\statusRequest at acceptJoinRequestToMyGroup  is $statusRequest");
    update(["acceptJoinRequest"]);
    var response =
        await myGroupData.postToAcceptJoinRequest(userIdToAcceptJoin);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at acceptJoinRequestToMyGroup: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getListOfStudentToJoinMyGroup();
        getPublicDeatilsOfMyGroup();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
        getListOfStudentToJoinMyGroup();
        getPublicDeatilsOfMyGroup();
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

    update(["acceptJoinRequest"]);
  }

  rejectJoinRequestToMyGroup(int userIdToRejecttJoin) async {
    statusRequest = StatusRequest.loading;
    debugPrint(
        "\\\\\\\\statusRequest at rejectJoinRequestToMyGroup  is $statusRequest");
    update(["acceptJoinRequest"]);
    var response =
        await myGroupData.postToRejectJoinRequest(userIdToRejecttJoin);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at rejectJoinRequestToMyGroup: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getListOfStudentToJoinMyGroup();
        getPublicDeatilsOfMyGroup();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
        getListOfStudentToJoinMyGroup();
        getPublicDeatilsOfMyGroup();
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

    update(["acceptJoinRequest"]);
  }

  int? form1Id;
////////////////////////////
////////////////////////////
////////////////////////////
  InfoOfProjectModel? infoOfProjectModel;
  getInfoOfProjectAndForms() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await myGroupData.getMyProjectDetailsAndForms();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        infoOfProjectModel = InfoOfProjectModel.fromJson(response);
        form1Id = infoOfProjectModel?.data?.form1?.id; 
        doctorName.value =
            infoOfProjectModel?.data?.form1?.supervisor ?? 'اسم الدكتور';
        //doctorId.value = infoOfProjectModel?.data?.form1?.id ?? 0 ;

        debugPrint("✅ getInfoOfProjectAndForms fetched");
        debugPrint(
            "✅ getInfoOfProjectAndForms fetched and form 1111111 is isss $form1Id");
      } catch (e) {
        debugPrint("❌ Parse error: $e");
        statusRequest = StatusRequest.failure;
      }
    }

    update();
  }

  String safe(String? s, [String fallback = '—']) =>
      (s == null || s.trim().isEmpty) ? fallback : s;

  Form1Model? get form1 => infoOfProjectModel?.data?.form1;
  Form2Model? get form2 => infoOfProjectModel?.data?.form2;
  GradesModel? get grades => infoOfProjectModel?.data?.grades;
  List<MembersAtProjectModel> get membersStudent =>
      infoOfProjectModel?.data?.members ?? [];

  List<String> get committeeImages {
    final c = grades?.committee;
    return [
      (c?.supervisorProfileImage ?? '').trim().isEmpty
          ? MyImageAsset.profileNoPic
          : c!.supervisorProfileImage!,
      (c?.memberProfileImage ?? '').trim().isEmpty
          ? MyImageAsset.profileNoPic
          : c!.memberProfileImage!,
    ];
  }

  List<String> get membersStudentImages => membersStudent
      .map((m) => (m.profileImage ?? '').trim().isEmpty
          ? MyImageAsset.profileNoPic
          : m.profileImage!)
      .toList();

  //edit form one
  late TextEditingController ideaNameArabic;
  late TextEditingController ideaNameEnglish;
  late TextEditingController ideaDesc;
  late TextEditingController projectScope;
  late TextEditingController sectorCalssificat;
  late TextEditingController targetSector;
  late TextEditingController stackholder;
  bool _form1CtrlsReady = false;

  void initForm1EditingFields() {
    if (_form1CtrlsReady) return;

    final f1 = form1; 
    ideaNameArabic = TextEditingController(text: f1?.title ?? '');
    ideaNameEnglish = TextEditingController(text: '');
    ideaDesc = TextEditingController(text: '');
    projectScope = TextEditingController(text: '');
    sectorCalssificat = TextEditingController(text: '');
    targetSector = TextEditingController(text: '');
    stackholder = TextEditingController(text: '');

    _form1CtrlsReady = true;
  }

  updateFormOne() async {
    statusRequest = StatusRequest.loading;
    debugPrint(
        "\\\\\\\\statusRequest at updateFormOne controller is $statusRequest");
    update();
    var response = await myGroupData.postToUpdateFormOne(
        form1Id ?? 0,
        groupId.toString(),
        doctorId.toString(),
        ideaNameArabic.text,
        ideaNameEnglish.text,
        ideaDesc.text,
        projectScope.text,
        targetSector.text,
        sectorCalssificat.text,
        stackholder.text);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at updateFormOne: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint(' updateFormOne ناجح - code $code');

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        //Get.back();
        //Get.offAllNamed(AppRoute.navBar);
        getInfoOfProjectAndForms();
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
        getInfoOfProjectAndForms();
        getMyGroupInfo();
        getPublicDeatilsOfMyGroup();
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

  MyServices myServices = Get.find();

  leaveGroup(int newLeaderId) async {
    if (groupId == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "لا يمكن تغيير القائد قبل تحديد المجموعة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at leave group  is $statusRequest");
    update();
    var response = await myGroupData.delToLeaveGroup(groupId!);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at leaveGroup: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        Get.offAllNamed(AppRoute.navBar);
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        myServices.sharedPreferences.setBool("is_in_group", false);
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
        getListOfMemberToTeamLeader();
      } else {
        debugPrint("❌leaveGroup استجابة غير متوقعة أو خطأ سيرفر - code $code");
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

  resendFormOne(int newLeaderId) async {
    if (form1Id == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "لا يمكن ارسال الاستمارة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at resendFormOne  is $statusRequest");
    update();
    var response = await myGroupData.postToResendForm1(form1Id!);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at resendFormOne: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;

        getMyGroupInfo();
        getPublicDeatilsOfMyGroup();
      } else {
        debugPrint("❌leaveGroup استجابة غير متوقعة أو خطأ سيرفر - code $code");
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

  Future<void> downloadFormOne(int formOneId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final either = await myGroupData.getToDownloadFormOne(formOneId);
      await either.fold(
        (err) async {
          statusRequest = err;
          showCustomSnackbar(
            title: "فشل",
            message: "تعذر الاتصال بالخادم",
            isSuccess: false,
          );
        },
        (res) async {
          final ct = (res.headers['content-type'] ?? '').toLowerCase();

          if (res.statusCode >= 400) {
            showCustomSnackbar(
              title: "خطأ",
              message: "HTTP ${res.statusCode}",
              isSuccess: false,
            );
            getMyGroupInfo();
            getPublicDeatilsOfMyGroup();
            statusRequest = StatusRequest.serverfaliure;
            return;
          }
          final bytes = res.bodyBytes;
          String filename = 'adv_$formOneId'; 
          final cd = res.headers['content-disposition'];
          if (cd != null) {
            final m = RegExp(r'filename\*?=([^;]+)').firstMatch(cd);
            if (m != null) {
              filename = m.group(1)!.replaceAll('"', '').trim();
            }
          }

          final savedPath = await _saveBytesToFile(bytes, filename, ct);

          await OpenFilex.open(savedPath); 
          debugPrint("📄 Saved to: $savedPath");

          showCustomSnackbar(
            title: "نجاح",
            message: "تم حفظ الملف: $filename",
            isSuccess: true,
          );
          statusRequest = StatusRequest.success;
        },
      );
    } catch (e) {
      debugPrint("✗ downloadAdv error: $e");
      showCustomSnackbar(
        title: "فشل التنزيل",
        message: "حدث خطأ أثناء التنزيل.",
        isSuccess: false,
      );
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }



  Future<void> downloadFormTow(int formTowId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      final either = await myGroupData.getToDownloadFormTow(formTowId);
      await either.fold(
        (err) async {
          statusRequest = err;
          showCustomSnackbar(
            title: "فشل",
            message: "تعذر الاتصال بالخادم",
            isSuccess: false,
          );
        },
        (res) async {
          final ct = (res.headers['content-type'] ?? '').toLowerCase();

          if (res.statusCode >= 400) {
            showCustomSnackbar(
              title: "خطأ",
              message: "HTTP ${res.statusCode}",
              isSuccess: false,
            );
            getMyGroupInfo();
            getPublicDeatilsOfMyGroup();
            statusRequest = StatusRequest.serverfaliure;
            return;
          }
          final bytes = res.bodyBytes;
          String filename = 'adv_$formTowId'; 
          final cd = res.headers['content-disposition'];
          if (cd != null) {
            final m = RegExp(r'filename\*?=([^;]+)').firstMatch(cd);
            if (m != null) {
              filename = m.group(1)!.replaceAll('"', '').trim();
            }
          }

          final savedPath = await _saveBytesToFile(bytes, filename, ct);

          await OpenFilex.open(savedPath); 
          debugPrint("📄 Saved to: $savedPath");

          showCustomSnackbar(
            title: "نجاح",
            message: "تم حفظ الملف: $filename",
            isSuccess: true,
          );
          statusRequest = StatusRequest.success;
        },
      );
    } catch (e) {
      debugPrint("✗ downloadAdv error: $e");
      showCustomSnackbar(
        title: "فشل التنزيل",
        message: "حدث خطأ أثناء التنزيل.",
        isSuccess: false,
      );
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }



  Future<String> _saveBytesToFile(
      Uint8List bytes, String filename, String? contentType) async {
    Directory dir;
    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory()) ??
          await getTemporaryDirectory();
    } else if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getTemporaryDirectory();
    }
    if (!filename.contains('.')) {
      if ((contentType ?? '').contains('pdf')) {
        filename += '.pdf';
      } else if ((contentType ?? '').contains('png')) {
        filename += '.png';
      } else if ((contentType ?? '').contains('jpeg') ||
          (contentType ?? '').contains('jpg')) {
        filename += '.jpg';
      }
    }

    final filePath = '${dir.path}/$filename';
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    return filePath;
  }

  signature(int formOneId) async {
    if (form1Id == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "لا يمكن تغيير القائد قبل تحديد المجموعة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\signature at changeLeader  is $statusRequest");
    update();
    var response = await myGroupData.postToSignature(formOneId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at signature: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getInfoOfProjectAndForms();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;

        getMyGroupInfo();
        getPublicDeatilsOfMyGroup();
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

  /////// part 11111111111111111111111
  ShowMemberToChangeLeaderModel? showMemberToChangeLeaderModel;
  List<MembersToChangeLeaderModel> membersToChangeTeamLeader = [];

  getListOfMemberToTeamLeader() async {
    if (groupId == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "لا يمكن تغيير القائد قبل تحديد المجموعة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    update(["changeLeader"]);

    var response = await myGroupData.getMemberToChangeLeader();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = ShowMemberToChangeLeaderModel.fromJson(response);

          membersToChangeTeamLeader = parsed.members ?? [];
          debugPrint(
              "getListOfMemberToTeamLeader تم جلب بيانات  بنجاح: ${membersToChangeTeamLeader.length} ");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint(
            "getListOfMemberToTeamLeader خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update(["changeLeader"]);
  }

  MyGroupPublicDeatilsModel? myGroupPublicDeatilsModel;
  List<MembersPublicDeatilsModel> memberAtMyGroup = [];
  getPublicDeatilsOfMyGroup({int? groupIdOverride}) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      final response = await myGroupData.getPublicDeatilsOfMyGroup();

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response["statusCode"] == 200 || response["statusCode"] == 201) {
          try {
            final parsed = MyGroupPublicDeatilsModel.fromJson(response);
            myGroupPublicDeatilsModel = parsed;
            memberAtMyGroup = parsed.details?.members ?? [];
            debugPrint(
              "✅ getPublicDeatilsOfMyGroup: groupId=${parsed.details?.groupId}, members=${memberAtMyGroup.length}",
            );
            groupId = parsed.details?.groupId ?? 0;
          } catch (e) {
            debugPrint("❌ Parse error (MyGroupPublicDeatilsModel): $e");
            statusRequest = StatusRequest.failure;
          }
        } else if (response.containsKey("title") &&
            response.containsKey("body")) {
          debugPrint("⚠️ Validation error content");
          statusRequest = StatusRequest.failure;
        } else {
          debugPrint("❌ Unexpected response / server error");
          statusRequest = StatusRequest.serverfaliure;
        }
      }
    } catch (e) {
      debugPrint("❌ Exception in getPublicDeatilsOfMyGroup: $e");
      statusRequest = StatusRequest.serverfaliure;
    }

    update();
  }

  changeLeader(int newLeaderId) async {
    if (groupId == null) {
      showCustomSnackbar(
        title: "خطأ",
        message: "لا يمكن تغيير القائد قبل تحديد المجموعة.",
        isSuccess: false,
      );
      return;
    }
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at changeLeader  is $statusRequest");
    update(["changeLeader"]);
    var response = await myGroupData.postToChangeLeader(newLeaderId, groupId!);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at registerData: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getPublicDeatilsOfMyGroup();
        getListOfMemberToTeamLeader();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
        getListOfMemberToTeamLeader();
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

    update(["changeLeader"]);
  }

  RxString doctorName = "اسم الدكتور".obs;
  RxInt doctorId = 0.obs;

  List<DoctorData> doctorForFormOneList = [];
  getListOfDoctorToSubmitFormOne() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await myGroupData.getDoctors();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        final parsed = DoctorForFormOneModel.fromJson(response);
        doctorForFormOneList = parsed.data ?? [];
        debugPrint(
            "getListOfDoctorToSubmitFormOne تم جلب بيانات بنجاح: ${doctorForFormOneList.length}");
      } catch (e) {
        debugPrint("❌ خطأ أثناء تحويل البيانات: $e");
        statusRequest = StatusRequest.failure;
      }
    } else {
      debugPrint("❌ فشل الطلب: $statusRequest");
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    groupName = TextEditingController();
    groupDescription = TextEditingController();
    ideaNameArabic = TextEditingController();
    ideaNameEnglish = TextEditingController();
    ideaDesc = TextEditingController();

    projectScope = TextEditingController();
    sectorCalssificat = TextEditingController();
    targetSector = TextEditingController();
    stackholder = TextEditingController();
    _init();
  }

  @override
  void dispose() {
    if (_form1CtrlsReady) {
      ideaNameArabic.dispose();
      ideaNameEnglish.dispose();
      ideaDesc.dispose();
      projectScope.dispose();
      sectorCalssificat.dispose();
      targetSector.dispose();
      stackholder.dispose();
    }
    super.dispose();
  }

  Future<void> _init() async {
    final args = Get.arguments as Map<String, dynamic>?;
    groupId = args?['groupId'] as int? ?? groupId;

    await getPublicDeatilsOfMyGroup();

    if (groupId == null) {
      debugPrint(
          '⚠️ groupId is null after getPublicDeatilsOfMyGroup; stop further calls.');
      return;
    }

    getMyGroupInfo();
    await getInfoOfProjectAndForms(); 
    await Future.wait([]);
  }
}
