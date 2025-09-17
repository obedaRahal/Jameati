import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class JoinToGroupData {
  final Crud crud;
  JoinToGroupData(this.crud);

  Future<dynamic> getGroupList() async {
    var response = await crud.getData(
      url: AppLink.getGroupListToJpinApi,
      headers: getAuthHeaders()
    );

    return response.fold((l) => l, (r) => r);
  }


  Future<dynamic> askToJoin(int idGroup) async {
    var response = await crud.postData(
      url: "${AppLink.askToJoinGroupApi}/$idGroup/join-request",
      headers: getAuthHeaders(),
      body: {}
    );

    return response.fold((l) => l, (r) => r);
  
  
  }
  Future<dynamic> cancelToJoin(int idGroup) async {
    var response = await crud.postData(
      url: "${AppLink.cancelToJoinGroupApi}/$idGroup/cancel",
      headers: getAuthHeaders(),
      body: {}
    );

    return response.fold((l) => l, (r) => r);
  }


}

