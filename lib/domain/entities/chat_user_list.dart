
import 'package:mini_project_chatapp/domain/entities/chat_message.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';

class ChatuserList{
  String id;
  List<Chatroom> users;
  List<ChatMessage> messages;

  ChatuserList({required this.id, required this.users, required this.messages});

  factory ChatuserList.fromJson(Map<String, dynamic> json){
    List<Chatroom> users = (json['users'] as List<dynamic>).map((userData){
      return Chatroom.fromJson(userData);
    }).toList();

    List<ChatMessage> messages = (json['messages'] as List<dynamic>).map((messageData) {
      return ChatMessage.fromJson(messageData);
    }).toList();

    return ChatuserList(
        id: json['id'],
        users: users,
        messages: messages
    );

  }
}