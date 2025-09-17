import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class ChatData {
  final Crud crud;
  ChatData(this.crud);

  Future<dynamic> postToGetAllMessageAtChat(
    int? conversationId, {
    String? beforeId, // ← نص
  }) async {
    final body = <String, String>{
      'conversation_id': '${conversationId ?? ''}',
      if (beforeId != null) 'before_id': beforeId, 
    };

    debugPrint('📤 POST getAllMessage (multipart) body = $body');

    final res = await crud.postData(
      url: "${AppLink.postToGetMessageAtChatApi}/$conversationId",
      body: body,
      useMultipart: true,          
      headers: getAuthHeaders(),     
    );

    return res.fold((l) => l, (r) => r);
  }

    postToSendMessage( int conversationId ,
    String msg, String type
  ) async {
    var response = await crud.postData(
        url: "${AppLink.postToSendMessageApi}/$conversationId",
        body: {
          "content": msg,
          "message_type": type,

        },
        useMultipart: true,
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }
}
