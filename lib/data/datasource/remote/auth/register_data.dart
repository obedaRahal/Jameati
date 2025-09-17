import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/link_api.dart';

class RegisterData {
  Crud crud;
  RegisterData(this.crud);

  postData(String email,String univerNumber, String password,
      String specification) async {
      var response = await crud.postData(
        url: AppLink.registerApi,
        body: {
          "email": email,
          "university_id": univerNumber,
          "password": password,
          "student_speciality": specification,
        },
        useMultipart: true,
      );

      return response.fold((l) => l, (r) => r);
    }
  }

