import 'dart:io';

import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class CreateGroupData {
  final Crud crud;
  CreateGroupData(this.crud);

  Future<dynamic> getStudentList() async {
    var response = await crud.getData(
        url: AppLink.getStudentListToInviteApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

Future<dynamic> postToCreateGroup({
  required String name,
  required String description,
  required List<String> specialityNeeded,
  required List<String> frameworkNeeded, 
  required File? image,
  required String type,               
  required List<int> invitations,       
}) async {
  final Map<String, dynamic> body = {
    "name": name,
    "description": description,
    "type": type,
    "speciality_needed": specialityNeeded,
    "framework_needed": frameworkNeeded,
    "invitations": invitations,
  };

  if (image != null) {
    body["image"] = image; // File
  }

  final response = await crud.postDataToCreateGroup(
    url: AppLink.createGroupApi,
    body: body,
    useMultipart: true,
    headers: getAuthHeaders(),
  );

  return response.fold((l) => l, (r) => r);
}

}
