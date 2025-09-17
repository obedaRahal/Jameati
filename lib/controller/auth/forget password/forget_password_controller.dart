import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/auth/forget%20password/forget_password_data.dart';

abstract class ForgetPasswordController extends GetxController {
  forgetPasswordAndGoToVerifyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController email;

  StatusRequest statusRequest = StatusRequest.none;
  ForgetPasswordData forgetPasswordData = ForgetPasswordData(Get.find());

  @override
  forgetPasswordAndGoToVerifyCode() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      debugPrint(
          "im at goingToVerifyCodePassword func at fogetcontroller at vvvvvalidddd");

      statusRequest = StatusRequest.loading;
      update();

      var response = await forgetPasswordData.postData(email.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        debugPrint("//////im at forgetpass: handling success response");
        final code = response["statusCode"];

        if (code == 200 || code == 201) {
          debugPrint('تسجيل ناجح - code $code');

          showCustomSnackbar(
            title: response["title"] ?? "نجاح",
            message: response["body"] ?? "تم بنجاح",
            isSuccess: true,
          );
          Get.toNamed(AppRoute.forgetPassword2 , arguments: {"email":email.text});

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
      debugPrint("im at login func at logincontrollller at unvalidddd");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
