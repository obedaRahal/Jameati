import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class NewChatData {
  final Crud crud;
  NewChatData(this.crud);

  Future<dynamic> getListsOUsers() async {
    var response = await crud.getData(
        url: AppLink.getListOfUsersToStartChatApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }


  Future<dynamic> getToCreateNewConversation(int memberId) async {
    var response = await crud.getData(
      url: "${AppLink.getToCreateNewConversationApi}/$memberId",
      headers: getAuthHeaders(),
    );

    return response.fold((l) => l, (r) => r);
  }
}
