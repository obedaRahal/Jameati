import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/auth/forget%20password/verify_code_forget_password_data.dart';

abstract class VerifyCodeForgetPasswordController extends GetxController {
  sendVerifyCodeAndGoToNewwPassword();

  resendCode();
}

class VerifyCodeForgetPasswordControllerImp
    extends VerifyCodeForgetPasswordController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email;
  late String verifyCode;

  StatusRequest statusRequest = StatusRequest.none;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData =
      VerifyCodeForgetPasswordData(Get.find());

  @override
  sendVerifyCodeAndGoToNewwPassword() async {
    debugPrint(" going to newpass screeen");
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      debugPrint(
          "im at verificatpassss func at VerifyCodeForgetPasswordController at vvvvvalidddd");
      //Get.toNamed(AppRoute.forgetPassword3);

      statusRequest = StatusRequest.loading;
      update();

      var response = await verifyCodeForgetPasswordData.postDataToVerify(
          email, verifyCode);
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
          Get.toNamed(AppRoute.forgetPassword3, arguments: {"email": email});
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
          "im at verificatpassss func at VerifyCodeForgetPasswordController at unvalidddd");
    }
  }

  @override
  resendCode() async {
    debugPrint(" resend code ");
    var formdata = formKey.currentState;

    debugPrint(
        "im at resendCode func at VerifyCodeForgetPasswordController at vvvvvalidddd");
    //Get.toNamed(AppRoute.forgetPassword3);

    statusRequest = StatusRequest.loading;
    update();

    var response =
        await verifyCodeForgetPasswordData.postDataToResendCode(email);
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
    email = Get.arguments["email"];
    super.onInit();
  }
}
