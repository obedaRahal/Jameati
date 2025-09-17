import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class NewPasswordData {
  final Crud crud;
  NewPasswordData(this.crud);

  Future<dynamic> postData(String email , String password ,String confirmPassword) async {
    var response = await crud.postData(
      url: AppLink.newPasswordApi,
      body: {
        "email": email,
        "password" : password,
        "password_confirmation" : confirmPassword,
      },
      useMultipart: true, 
    );

    return response.fold((l) => l, (r) => r);
  }

}