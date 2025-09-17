
import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class ForgetPasswordData {
  final Crud crud;
  ForgetPasswordData(this.crud);

  Future<dynamic> postData(String email) async {
    var response = await crud.postData(
      url: AppLink.forgetPasswordApi,
      body: {
        "email": email,
      },
      useMultipart: true, 
    );

    return response.fold((l) => l, (r) => r);
  }
}

