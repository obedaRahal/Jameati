import 'dart:io';

import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class MyProfileData {
  final Crud crud;
  MyProfileData(this.crud);

  Future<dynamic> getMyProfile() async {
    var response = await crud.getData(
        url: AppLink.grtMyProfileApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postToUpdateProfile(String governorate, String phoneNumber,
      String birthDate, String studentSpeciality) async {
    var response = await crud.postData(
      url: AppLink.updateProfileInfoApi,
      headers: getAuthHeaders(),
      body: {
        "governorate": "governorate",
        "phone_number": phoneNumber,
        "birth_date": birthDate,
        "student_speciality": studentSpeciality,
      },
      //useMultipart: true
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postData(String governorate, String phoneNumber,
      String birthDate, String studentSpeciality) async {
    var response = await crud.postData(
      url: AppLink.updateProfileInfoApi,
      headers: getAuthHeaders(),
      body: {
        "governorate": governorate,
        "phone_number": phoneNumber,
        "birth_date": birthDate,
        "student_speciality": studentSpeciality,
      },
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> updateProfilePic({
    required File? image,
  }) async {
    final Map<String, dynamic> body = {};
    if (image != null) {
      body["profile_image"] = image;
    }
    final response = await crud.postDataToCreateGroup(
      url: AppLink.updateProfilePicApi,
      body: body,
      useMultipart: true,
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getToLogOut() async {
    final response = await crud.getData(
      url: AppLink.getToLogOutApi,
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }
}
