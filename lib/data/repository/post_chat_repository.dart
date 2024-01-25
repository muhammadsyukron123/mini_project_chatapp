

import 'dart:convert';

import 'package:mini_project_chatapp/data/remote/remote_chat_datasource.dart';
import 'package:mini_project_chatapp/domain/entities/chat_sendmessage.dart';

class PostChatRepository {
  var remoteChatDataSource = RemoteChatDatasource();

  Future<bool> postChat(ChatSendMessage chatSendMessage) async {
    var response = await remoteChatDataSource.postChat(chatSendMessage.toJson());
    print(response);
    return jsonDecode(response)['data']; // Fix this line
  }
}