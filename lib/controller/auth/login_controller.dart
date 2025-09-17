import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/core/services/services.dart';
import 'package:project_manag_ite/data/datasource/remote/auth/login_data.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
  showPassword();
  sendVerifyCode();
}

class LoginControllerImp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;

  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.find());

  MyServices myServices = Get.find();


  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  login() async {
      final fcmToken = myServices.sharedPreferences.getString("fcm_token");

    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at login controller is $statusRequest");
    update();
    var response = await loginData.postToLogIn(email.text, password.text ,fcmToken?? "");
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at login: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('تسجيل دخول ناجح - code $code');
        myServices.sharedPreferences.setString("login", "2");

        myServices.sharedPreferences.setString("token", response["token"]);
        myServices.sharedPreferences
            .setString("name", response["name"] ?? "اسم ");
        myServices.sharedPreferences
            .setString("profile_image", response["profile_image"] ?? "");
        debugPrint("token isssssss ${myServices.sharedPreferences.getString("token")}");

        myServices.sharedPreferences.setBool("is_in_group", response["is_in_group"]);
        debugPrint("is_in_group isssssss ${myServices.sharedPreferences.getBool("is_in_group")}");
                debugPrint("and fcccccm token  isssssss $fcmToken ");




        Get.offAllNamed(AppRoute.navBar);
        return;
      }

      if (response["verify"] == false) {
        debugPrint("⚠️ الحساب غير مفعل");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "يرجى تأكيد الحساب",
          isSuccess: false,
          acceptClick: true,
          onTap: () {
            sendVerifyCode();
            Get.toNamed(AppRoute.verificationRegister, arguments: {
              "email": email.text,
              //"source": "login",
            });
          },
        );

        statusRequest = StatusRequest.failure;
      } else
      //if (code == 422 || code == 400) {
      if (response.containsKey("title") && response.containsKey("body")) {
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
  sendVerifyCode() async {
    debugPrint(" resend code ");

    debugPrint(
        "im at resendCode func at VerifyCodeForgetPasswordController at vvvvvalidddd");
    //Get.toNamed(AppRoute.forgetPassword3);

    statusRequest = StatusRequest.loading;
    update();

    var response = await loginData.postDataToResendCode(email.text);
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
  goToForgetPassword() {
    debugPrint("forget password ");
    Get.toNamed(AppRoute.forgetPassword1);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

}
