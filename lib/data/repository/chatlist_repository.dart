

import 'dart:convert';

import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';

import '../remote/remote_chat_datasource.dart';

class ChatUserlistRepository {
  var remoteChatDatasource = RemoteChatDatasource();

  Future<ChatuserList> getChatuserList(String id) async{
    var jsonArray = jsonDecode(await remoteChatDatasource.getChatlist(id))['data'];
    ChatuserList chatroom = ChatuserList.fromJson(jsonArray);
    return chatroom;
  }

}