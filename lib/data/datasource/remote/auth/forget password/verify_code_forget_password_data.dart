import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class VerifyCodeForgetPasswordData {
  final Crud crud;
  VerifyCodeForgetPasswordData(this.crud);

  Future<dynamic> postDataToVerify(String email, String verifyCode) async {
    var response = await crud.postData(
      url: AppLink.verifyCodeforgetPasswordApi,
      body: {"email": email, "otp_code": verifyCode},
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postDataToResendCode(String email) async {
    var response = await crud.postData(
      url: AppLink.resendCodeVerifyAtForgetpasswordApi,
      body: {
        "email": email,
      },
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
