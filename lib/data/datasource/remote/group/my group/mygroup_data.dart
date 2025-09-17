import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';
import 'package:http/http.dart' as http;

class MyGroupData {
  final Crud crud;
  MyGroupData(this.crud);

  Future<dynamic> getJoinRequestList(int groupId) async {
    var response = await crud.getData(
        url: "${AppLink.showJoinRequestApi}/$groupId/join-requests",
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  postToAcceptJoinRequest(int userIdToAcceptJoin) async {
    var response = await crud.postData(
      url: "${AppLink.acceptJoinToMyGroupApi}/$userIdToAcceptJoin/accept",
      body: {},
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  postToRejectJoinRequest(int userIdToRejectJoin) async {
    var response = await crud.postData(
      url: "${AppLink.rejectJoinToMyGroupApi}/$userIdToRejectJoin/reject",
      body: {},
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getMemberToChangeLeader() async {
    var response = await crud.getData(
        url: AppLink.myGroupMembersApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getPublicDeatilsOfMyGroup() async {
    var response = await crud.getData(
        url: AppLink.myGroupPublicDeatilsApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getMyProjectDetailsAndForms() async {
    var response = await crud.getData(
        url: AppLink.myProjectAndFormDetailsApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  postToChangeLeader(int newLeaderId, int groupId) async {
    var response = await crud.postData(
      url: "${AppLink.changeLeaderApi}/$groupId/change-leader",
      body: {
        "new_leader_id": "$newLeaderId",
      },
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  delToLeaveGroup(int groupId) async {
    var response = await crud.deleteData(
      url: "${AppLink.delToLeaveGroupApi}/$groupId/leave",
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }

  postToResendForm1(int form1Id) async {
    var response = await crud.postData(
        url: "${AppLink.postToResendForm1Api}/$form1Id/submit",
        headers: getAuthHeaders(),
        body: {});

    return response.fold((l) => l, (r) => r);
  }

  postToUpdateFormOne(
    int formId,
    String groupId,
    String userId,
    String arabicTitle,
    String englishTitle,
    String description,
    String projectScope,
    String targetedSector,
    String sectorClassification,
    String stakeholders,
  ) async {
    var response = await crud.postData(
        url: "${AppLink.postToUpdateForm1Api}/$formId",
        body: {
          "group_id": groupId,
          "user_id": userId,
          "arabic_title": arabicTitle,
          "english_title": englishTitle,
          "description": description,
          "project_scope": projectScope,
          "targeted_sector": targetedSector,
          "sector_classification": sectorClassification,
          "stakeholders": stakeholders,
        },
        useMultipart: true,
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getMyGroupInfo() async {
    var response = await crud.getData(
        url: AppLink.myGroupInfoApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> updateGroupInfo({
    required String name,
    required String description,
    required List<String> specialityNeeded, 
    required List<String> frameworkNeeded, 
    required File? image,
    required String type, 
    required int groupId, 
  }) async {
    final Map<String, dynamic> body = {
      "name": name,
      "description": description,
      "type": type,
      "speciality_needed": specialityNeeded,
      "framework_needed": frameworkNeeded,
    };

    if (image != null) {
      body["image"] = image; 
    }

    final response = await crud.postDataToCreateGroup(
      url: "${AppLink.updateGroupInfo}/$groupId",
      body: body,
      useMultipart: true,
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getDoctors() async {
    var response = await crud.getData(
        url: AppLink.getDoctorForFormOneApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<Either<StatusRequest, http.Response>> getToDownloadFormOne(
      int formOneId) async {
    return await crud.getBytes(
      url: "${AppLink.getToDownloadFormOneApi}/$formOneId/download",
      headers: getAuthHeaders(), 
    );
  }

  Future<Either<StatusRequest, http.Response>> getToDownloadFormTow(
      int formTowId) async {
    return await crud.getBytes(
      url: "${AppLink.getToDownloadFormTowApi}/$formTowId/download",
      headers: getAuthHeaders(), 
    );
  }

  postToSignature(int formOneId) async {
    var response = await crud.postData(
      url: "${AppLink.postToSignatureFormOneApi}/$formOneId/sign",
      body: {},
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
