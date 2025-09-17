import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';
class ChatListData {
  final Crud crud;
  ChatListData(this.crud);

  Future<dynamic> getAllConversation() async {
    final response = await crud.getListData(
      url: AppLink.getAllChatApi,
      headers: getAuthHeaders(),
    );
    return response.fold((l) => l, (r) => r); // Map فيه statusCode + data(List)
  }
}
