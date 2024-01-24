
import 'package:mini_project_chatapp/data/repository/chat_repository.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';

class GetChatroom{
  var repository = ChatRepository();

  Future<Chatroom> execute(String username) async {
    return repository.getChatrooms(username);
  }

}