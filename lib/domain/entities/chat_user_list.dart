
import 'package:mini_project_chatapp/domain/entities/chat_message.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';

// class ChatuserList {
//   String id;
//   List<Chatroom> users;
//   List<ChatMessage> messages;
//
//   ChatuserList({required this.id, required this.users, required this.messages});
//
//   factory ChatuserList.fromJson(Map<String, dynamic> json) {
//     print('ini users: ${json['users']}');
//     print('ini messages: ${json['messages']}');
//
//     List<Chatroom> users = (json['users'] as List<dynamic>).map((userData) {
//       return Chatroom.fromJson(userData);
//     }).toList();
//
//     List<ChatMessage> messages = (json['messages'] as List<dynamic>).map((messageData) {
//       return ChatMessage.fromJson(messageData);
//     }).toList();
//
//     return ChatuserList(
//       id: json['id'],
//       users: users,
//       messages: messages,
//     );
//   }
//
// }

class ChatuserList {
  // String id;
  List<String> usernames; // List of usernames
  List<ChatMessage> messages;

  ChatuserList({required this.usernames, required this.messages});

  factory ChatuserList.fromJson(Map<String, dynamic> json) {
    print('ini users: ${json}');

    var users = <String>[];
    for(var i = 0; i < json['users'].length; i++){
      users.add(json['users'][i]);
      print('User $i: ${json['users'][i]}');
    }

    var messages = <ChatMessage>[];
    for(var j = 0; j < json['messages'].length; j++){
      messages.add(ChatMessage.fromJson(json['messages'][j]));
      print('Message $j: ${json['messages'][j]}');
    }


    print('Raw message: $messages');
    return ChatuserList(
      usernames: users,
      messages: messages,
    );




    // List<String> usernames = (json['users'] as List<dynamic>).cast<String>();
    // print('ini list usernames kalo kebaca ${usernames}');
    //
    // return ChatuserList(
    //   id: json['id'],
    //   usernames: usernames,
    // );

  }

// List<Chatroom> getUserChatrooms() {
//   return usernames.map((username) {
//     return Chatroom(username: username, rooms: []); // Create Chatroom objects based on usernames
//   }).toList();
// }
}
