import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/auth/register_data.dart';

abstract class RegisterController extends GetxController {
  register();
  showPassword();
}

class RegisterControllerImp extends RegisterController {

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController univercityNum;
  late TextEditingController specification;

  RxString selectedSpecification = ''.obs;
  RxBool isSpecInvalid = false.obs;

  StatusRequest statusRequest = StatusRequest.none;
  RegisterData registerData = RegisterData(Get.find());

  bool isShowPassword = true;

  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  register() async {
    //Get.toNamed(AppRoute.verificationRegister , arguments: {"email" : email.text});
    debugPrint("number is ${univercityNum.text}");
    debugPrint("email is ${email.text}");
    debugPrint("password is ${password.text}");
    debugPrint(
        "specefication is ${specification.text} and selected selectedSpecification is $selectedSpecification");

    statusRequest = StatusRequest.loading;
    debugPrint(
        "\\\\\\\\statusRequest at register controller is $statusRequest");
    update();
    var response = await registerData.postData(
        email.text, univercityNum.text, password.text, specification.text);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at registerData: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل حساب ناجح - code $code');

        showCustomSnackbar(
            title: response["title"] ?? "نجاح",
            message: response["body"] ?? "تم بنجاح",
            isSuccess: true,
          );
        Get.toNamed(AppRoute.verificationRegister,
            arguments: {"email": email.text});
        
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
    email = TextEditingController();
    password = TextEditingController();
    univercityNum = TextEditingController();
    specification = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    univercityNum.dispose();
    specification.dispose();
    super.dispose();
  }
}
