import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class VerificatRegisterData {
  Crud crud;
  VerificatRegisterData(this.crud);

 Future<dynamic> postDataToSendVerificatCode(String email , String verifyCode) async {
    var response = await crud.postData(
      url: AppLink.verifyRegisterApi,
      body: {
        "email": email,
        "otp_code" : verifyCode
      },
      useMultipart: true, 
    );

    return response.fold((l) => l, (r) => r);
  }


      Future<dynamic> postDataToResendCode(String email ) async {
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
