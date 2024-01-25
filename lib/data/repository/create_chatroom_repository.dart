

import 'dart:convert';

import 'package:mini_project_chatapp/data/remote/remote_chat_datasource.dart';
import 'package:mini_project_chatapp/domain/entities/chat_createroom.dart';
import 'package:mini_project_chatapp/domain/usecase/create_chatroom.dart';

class CreateChatroomRepository{
  var remoteChatDataSource = RemoteChatDatasource();


  Future<String> createChatroom(CreateChatRoom createChatRoom) async{
    var response = await remoteChatDataSource.createChatRoom(createChatRoom.toJson());
    return jsonDecode(response)['data'];
  }

}