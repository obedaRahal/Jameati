import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/form_tow_data.dart/form_tow_data.dart';

abstract class FormTowController extends GetxController {}

class FormTowControllerImp extends FormTowController {
  late TextEditingController arabicTitle;
  late TextEditingController userSegment;
  late TextEditingController developmentProcedure;
  late TextEditingController libraryTools;

  // ملفات PDF المختارة
  final Rxn<PlatformFile> executionMap = Rxn<PlatformFile>(); // خارطة التنفيذ
  final Rxn<PlatformFile> workMap = Rxn<PlatformFile>(); // خارطة العمل

  StatusRequest statusRequest = StatusRequest.none;
  FormTowData formTowData = FormTowData(Get.find());

  Future<void> pickExecutionMap() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'], // ⬅️ PDF فقط
      withReadStream: true, // للرفع لاحقًا
      withData: false, // حافظ على الذاكرة (موبايل)
    );
    if (res != null && res.files.isNotEmpty) {
      executionMap.value = res.files.single;
    }
  }

  Future<void> pickWorkMap() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'], // ⬅️ PDF فقط
      withReadStream: true,
      withData: false,
    );
    if (res != null && res.files.isNotEmpty) {
      workMap.value = res.files.single;
    }
  }

  void clearExecutionMap() => executionMap.value = null;
  void clearWorkMap() => workMap.value = null;

  Future<void> previewPdf(PlatformFile? file) async {
    if (file?.path == null) return;
    await OpenFilex.open(file!.path!);
  }

  // (اختياري) فحص قبل الإرسال
  bool validateMapsSelected() {
    return executionMap.value != null && workMap.value != null;
  }

  @override
  void onInit() {
    arabicTitle = TextEditingController();
    userSegment = TextEditingController();
    developmentProcedure = TextEditingController();
    libraryTools = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    arabicTitle.dispose();
    userSegment.dispose();
    developmentProcedure.dispose();
    libraryTools.dispose();
    super.dispose();
  }

  // creteFormTow() async {
  //   statusRequest = StatusRequest.loading;
  //   debugPrint(
  //       "\\\\\\\\statusRequest at creteFormTow controller is $statusRequest");
  //   update();
  //   var response = await formTowData.postToCreateFormTow(
  //       arabicTitle.text,
  //       userSegment.text,
  //       developmentProcedure.text,
  //       libraryTools.text,
  //       executionMap,
  //       workMap);
  //   statusRequest = handlingData(response);

  //   if (statusRequest == StatusRequest.success) {
  //     debugPrint("//////im at creteFormTow: handling success response");
  //     final code = response["statusCode"];

  //     if (code == 200 || code == 201) {
  //       debugPrint('تسجيل حساب ناجح - code $code');

  //       showCustomSnackbar(
  //         title: response["title"] ?? "نجاح",
  //         message: response["body"] ?? "تم بنجاح",
  //         isSuccess: true,
  //       );
  //       //Get.back();
  //       Get.offAllNamed(AppRoute.navBar);
  //     } else if (response.containsKey("title") &&
  //         response.containsKey("body")) {
  //       debugPrint("⚠️ خطأ فاليديشن - code $code");
  //       showCustomSnackbar(
  //         title: response["title"] ?? "خطأ",
  //         message: response["body"] ?? "تحقق من البيانات المدخلة",
  //         isSuccess: false,
  //       );
  //       statusRequest = StatusRequest.failure;
  //     } else {
  //       debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
  //       showCustomSnackbar(
  //         title: "خطأ في الخادم",
  //         message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
  //         isSuccess: false,
  //       );
  //       statusRequest = StatusRequest.serverfaliure;
  //     }
  //   }

  //   update();
  // }

  
creteFormTow() async {
  // تحقّق سريع
  final exec = executionMap.value;
  final work = workMap.value;

  if (exec == null || work == null) {
    showCustomSnackbar(
      title: "مطلوب ملفات",
      message: "الرجاء اختيار ملفي PDF (خارطة التنفيذ وخارطة العمل).",
      isSuccess: false,
    );
    return;
  }

  // تأكد من الامتداد PDF
  bool isPdf(String? name) => (name ?? '').toLowerCase().endsWith('.pdf');
  if (!isPdf(exec.name) || !isPdf(work.name)) {
    showCustomSnackbar(
      title: "تنسيق غير مدعوم",
      message: "يجب اختيار ملفات بصيغة PDF فقط.",
      isSuccess: false,
    );
    return;
  }

  // على الموبايل PlatformFile.path يكون موجود
  if (exec.path == null || work.path == null) {
    showCustomSnackbar(
      title: "تعذر الوصول للملف",
      message: "لم يتم العثور على مسار الملف. جرّب اختيار الملف مرة أخرى.",
      isSuccess: false,
    );
    return;
  }

  statusRequest = StatusRequest.loading;
  debugPrint("\\\\\\\\statusRequest at creteFormTow controller is $statusRequest");
  update();

  final response = await formTowData.postToCreateFormTow(
    arabicTitle.text,
    userSegment.text,
    developmentProcedure.text,
    libraryTools.text,
    File(exec.path!), // ⬅️ تحويل إلى File
    File(work.path!), // ⬅️ تحويل إلى File
    // // اختياري: أسماء الملفات الأصلية
    // exec.name,
    // work.name,
  );

  statusRequest = handlingData(response);

  if (statusRequest == StatusRequest.success) {
    final code = response["statusCode"];
    if (code == 200 || code == 201) {
      showCustomSnackbar(
        title: response["title"] ?? "نجاح",
        message: response["body"] ?? "تم بنجاح",
        isSuccess: true,
      );
      Get.offAllNamed(AppRoute.navBar);
    } else if (response.containsKey("title") && response.containsKey("body")) {
      showCustomSnackbar(
        title: response["title"] ?? "خطأ",
        message: response["body"] ?? "تحقق من البيانات المدخلة",
        isSuccess: false,
      );
      statusRequest = StatusRequest.failure;
    } else {
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
}
