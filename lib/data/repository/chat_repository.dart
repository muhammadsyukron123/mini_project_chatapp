import 'package:mini_project_chatapp/data/remote/remote_chat_datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mini_project_chatapp/domain/entities/chat_room.dart';

class ChatRepository {
  var remoteChatDatasource = RemoteChatDatasource();

  Future<Chatroom> getChatrooms(String username) async{
    var jsonArray = jsonDecode(await remoteChatDatasource.getChatrooms(username))['data'];
    Chatroom chatroom = Chatroom.fromJson(jsonArray);
    print(jsonArray.toString());
    return chatroom;
  }
}