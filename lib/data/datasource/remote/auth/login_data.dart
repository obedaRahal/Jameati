import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class LoginData {
  final Crud crud;
  LoginData(this.crud);

  Future<dynamic> postToLogIn(String email, String password , String fcmToken) async {
    var response = await crud.postData(
      url: AppLink.loginApi,
      body: {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
      },
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postDataToResendCode(String email) async {
    var response = await crud.postData(
      url: AppLink.resendCodeVerifyAtRegisterApi,
      body: {
        "email": email,
      },
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
