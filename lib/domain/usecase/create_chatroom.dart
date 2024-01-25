


import 'package:mini_project_chatapp/data/repository/create_chatroom_repository.dart';
import 'package:mini_project_chatapp/domain/entities/chat_createroom.dart';

class CreateChatroom{
  var repository = CreateChatroomRepository();

  Future<bool> execute(CreateChatRoom createChatRoom){
    return repository.creatChatroom(createChatRoom);
  }

}