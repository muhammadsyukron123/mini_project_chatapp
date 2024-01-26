

import 'dart:convert';

import 'package:mini_project_chatapp/data/remote/remote_chat_datasource.dart';
import 'package:mini_project_chatapp/domain/entities/chat_createroom.dart';


class CreateChatroomRepository{
  var remoteChatDataSource = RemoteChatDatasource();


  Future<String> createChatroom(CreateChatRoom createChatRoom) async {
    var response = await remoteChatDataSource.createChatRoom(createChatRoom.toJson());
    print('print createchatroom response${response}');
    var responseData = jsonDecode(response)['data'];
    print('Ini response data createchatroom : ${responseData}');

    if (responseData != null) {
      return responseData;
    } else {
      throw Exception('Error creating chatroom: Null response data');
    }
  }


}