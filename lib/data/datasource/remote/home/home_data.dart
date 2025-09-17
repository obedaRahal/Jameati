import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class HomeData {
  final Crud crud;
  HomeData(this.crud);

  Future<dynamic> getFormDates() async {
    var response = await crud.getData(
        url: AppLink.getFormDates, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getStatistics() async {
    var response = await crud.getData(
        url: AppLink.getStatisticsApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getNotificationCount() async {
    var response = await crud.getData(
        url: AppLink.getNotificationCountApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getNotificationList() async {
    var response = await crud.getData(
        url: AppLink.getNotificationListApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getListOfFullGroups() async {
    var response = await crud.getData(
        url: AppLink.getListOfCompleteGroupApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  // Future<dynamic> postToSendRequestSixthPerson(
  //     int selectedGroupId, String description) async {
  //   var response = await crud.postData(
  //       url:
  //           "${AppLink.postToAskForSixthPerson}/$selectedGroupId/join-request-sixth",
  //       body: {
  //         "description": description,
  //       },
  //       headers: getAuthHeaders());

  //   return response.fold((l) => l, (r) => r);
  // }

  Future<dynamic> postToSendRequestSixthPerson(
    int selectedGroupId,
    String description,
  ) async {
    final response = await crud.postData(
      url:
          "${AppLink.postToAskForSixthPerson}/$selectedGroupId/join-request-sixth",
      body: {
        "description": description,
      },
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postToGetTopProject(int year) async {
    final response = await crud.getData(
      url: "${AppLink.postToGetTopProjectApi}/?year=$year",
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  
  
  }
  Future<dynamic> gettheNumberOfAdvs() async {
    final response = await crud.getData(
      url: AppLink.getNumberOfAdvApi,
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }


}
