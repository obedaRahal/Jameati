import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class InvitationData {
  final Crud crud;
  InvitationData(this.crud);

  Future<dynamic> getListOfInvitation() async {
    var response = await crud.getData(
      url: AppLink.getListOfInvitationApi,
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }


   postToAcceptInvitation(int invId) async {
    var response = await crud.postData(
      url: "${AppLink.postToAcceptInvitationApi}/$invId/accept",
      body: {},
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }


   postToRejectInvitation(int invId) async {
    var response = await crud.postData(
      url: "${AppLink.postToRejectInvitationApi}/$invId/reject",
      body: {},
      headers: getAuthHeaders(),
      useMultipart: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
