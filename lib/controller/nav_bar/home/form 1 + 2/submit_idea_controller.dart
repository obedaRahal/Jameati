import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/submit%20form%20one/submit_idea_data.dart';
import 'package:project_manag_ite/data/model/form%20one/doctor_for_formone_model.dart';
import 'package:project_manag_ite/data/model/form%20one/member_for_formone_model.dart';

abstract class SubmitIdeaController extends GetxController {}

class SubmitIdeaControllerImp extends SubmitIdeaController {
  RxString doctorName = "اسم الدكتور".obs;
  RxInt doctorId = 0.obs;

  late TextEditingController ideaNameArabic;
  late TextEditingController ideaNameEnglish;
  late TextEditingController ideaDesc;
  late TextEditingController projectScope;
  late TextEditingController sectorCalssificat;
  late TextEditingController targetSector;
  late TextEditingController stackholder;

  StatusRequest statusRequest = StatusRequest.none;
  SubmitIdeaData submitIdeaData = SubmitIdeaData(Get.find());
  MemberForFormOneModel? memberForFormOneModel;

  List<DataMember> membersAtMyGroupList = [];
  getListOfMemberToSubmitFormOne() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await submitIdeaData.getMember();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        final parsed = MemberForFormOneModel.fromJson(response);
        membersAtMyGroupList = parsed.data ?? [];
        debugPrint(
            "getListOfMemberToTeamLeader تم جلب بيانات بنجاح: ${membersAtMyGroupList.length}");
      } catch (e) {
        debugPrint("❌ خطأ أثناء تحويل البيانات: $e");
        statusRequest = StatusRequest.failure;
      }
    } else {
      // ممكن تعرض رسالة خطأ حسب الحالة
      debugPrint("❌ فشل الطلب: $statusRequest");
    }

    update();
  }

  List<DoctorData> doctorForFormOneList = [];
  getListOfDoctorToSubmitFormOne() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await submitIdeaData.getDoctors();
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
      // ممكن تعرض رسالة خطأ حسب الحالة
      debugPrint("❌ فشل الطلب: $statusRequest");
    }

    update();
  }

  creteFormOne() async {
    statusRequest = StatusRequest.loading;
    debugPrint(
        "\\\\\\\\statusRequest at creteFormOne controller is $statusRequest");
    update(["create"]);
    var response = await submitIdeaData.postToCreateFormOne(
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
      debugPrint("//////im at creteFormOne: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل حساب ناجح - code $code');

        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        //Get.back(); 
        Get.offAllNamed(AppRoute.navBar);

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

    update(["create"]);
  }

  @override
  void onInit() {
    ideaNameArabic = TextEditingController();
    ideaNameEnglish = TextEditingController();
    ideaDesc = TextEditingController();

    projectScope = TextEditingController();
    sectorCalssificat = TextEditingController();
    targetSector = TextEditingController();
    stackholder = TextEditingController();

    getListOfMemberToSubmitFormOne();

    super.onInit();
  }

  @override
  void dispose() {
    ideaNameArabic.dispose();
    ideaNameEnglish.dispose();
    ideaDesc.dispose();

    projectScope.dispose();
    sectorCalssificat.dispose();
    targetSector.dispose();
    stackholder.dispose();
    super.dispose();
  }
}
