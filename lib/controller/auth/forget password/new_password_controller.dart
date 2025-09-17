import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/auth/forget%20password/new_password_data.dart';

abstract class NewPasswordController extends GetxController {
  newPassword();
  goingWelcom();
  showPassword();
}

class NewPasswordControllerImp extends NewPasswordController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController password;
  late TextEditingController rePassword;
  late String email;

  StatusRequest statusRequest = StatusRequest.none;
  NewPasswordData newPasswordData = NewPasswordData(Get.find());

  bool isShowPassword = true;
  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  newPassword() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      debugPrint(
          "im at newpasss func at newpasswoerddddddddddControllller at vvvvvalidddd");
      //goingHome();

      statusRequest = StatusRequest.loading;
      update();

      var response =
          await newPasswordData.postData(email, password.text, rePassword.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        debugPrint("//////im at verificatpassss: handling success response");
        final code = response["statusCode"];

        if (code == 200 || code == 201) {
          debugPrint('تسجيل ناجح - code $code');

          showCustomSnackbar(
            title: response["title"] ?? "نجاح",
            message: response["body"] ?? "تم بنجاح",
            isSuccess: true,
          );

          goingWelcom();
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
    } else {
      debugPrint(
          "im at newpasss func at newpasswoerddddddddddControllller at unvalidddd");
    }
  }

  @override
  goingWelcom() {
    Get.offAllNamed(AppRoute.welccm);
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    password = TextEditingController();
    rePassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    rePassword.dispose();
    super.dispose();
  }
}
