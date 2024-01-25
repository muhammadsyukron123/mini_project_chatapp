
import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';
import 'package:mini_project_chatapp/domain/entities/chat_sendmessage.dart';
import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/domain/usecase/post_chat.dart';

class ChatPage extends StatefulWidget {
  late String username;
  late String id;
  late String senderUser;

  ChatPage(this.username, this.id, this.senderUser);

  @override
  State<StatefulWidget> createState() => _ChatPageState(this.username, this.id, this.senderUser);
}

class _ChatPageState extends State<ChatPage> {
  late String username;
  late String id;
  late String senderUser;
  late Future<ChatuserList> chatUserData;
  TextEditingController _messageController = TextEditingController();


  _ChatPageState(this.username, this.id, this.senderUser);

  @override
  void initState() {
    chatUserData = GetChatlist().execute(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User: ${username}'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ChatuserList>(
                  future: chatUserData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Center(child: Text('Error loading chatroom'));
                    } else {
                      final message = snapshot.data!;
                      final chats = message.messages;

                      return ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          var message = chats[index].text;
                          var username = chats[index].username;
                          return ListTile(
                              title: Text(username),
                              subtitle: Text(message),
                          );
                        },
                      );
                    }
                  })
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                    onPressed: () async {
                      await PostChat().execute(
                          ChatSendMessage(
                              id: id,
                              senderUsername: senderUser,
                              text: _messageController.text
                          )
                      );

                      setState(() {
                        chatUserData = GetChatlist().execute(id);
                      });
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}