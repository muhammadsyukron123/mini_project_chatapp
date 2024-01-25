//
//
// import 'package:mini_project_chatapp/data/repository/chat_repository.dart';
// import 'package:mini_project_chatapp/domain/entities/chat_sendmessage.dart';
//
// class PostMessage{
//   var repository = ChatRepository();
//
//   Future<bool> execute(ChatSendMessage chatSendMessage){
//     return repository.postMessage(chatSendMessage);
//   }
// }

import 'package:mini_project_chatapp/data/repository/post_chat_repository.dart';
import 'package:mini_project_chatapp/domain/entities/chat_sendmessage.dart';

class PostChat{
  var repository = PostChatRepository();

  Future<bool> execute(ChatSendMessage chatSendMessage){
    return repository.postChat(chatSendMessage);
  }
}