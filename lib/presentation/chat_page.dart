
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';
import 'package:mini_project_chatapp/domain/entities/chat_sendmessage.dart';
import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/domain/usecase/post_chat.dart';
import 'package:mini_project_chatapp/presentation/chat_room_page.dart';
import 'package:mini_project_chatapp/presentation/login_page.dart';

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
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                setState(() {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChatroomPage(senderUser))
                  );
                });
              },
              icon: Icon(Icons.arrow_back_rounded)
          ),
          title: ListTile(leading: CircleAvatar(
              child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,)
              )
          ),
            title: Text(username),
      
          ),
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
                            int timestamp = int.parse(chats[index].timestamp);
                            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
                            String formattedTime = DateFormat('HH:mm').format(dateTime);
                            var message = chats[index].text;
                            var username = chats[index].username;
                            return ListTile(
                                  title: Align(
                                    alignment: chats[index].username == senderUser ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Text(
                                      '${chats[index].username}', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w100),
                                    ),
                                  ),
                                  subtitle:
                                    Align(
                                      alignment: chats[index].username == senderUser ? Alignment.centerRight : Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: chats[index].username == senderUser ? Colors.indigo.withOpacity(0.8) : Colors.grey.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('${chats[index].text}', style: TextStyle(color: chats[index].username == senderUser ? Colors.white : Colors.black ), textAlign: chats[index].username == senderUser ? TextAlign.right : TextAlign.left),
                                            Text('${formattedTime}', style: TextStyle(fontSize: 12.0, color: chats[index].username == senderUser ? Colors.white : Colors.black), textAlign: chats[index].username == senderUser ? TextAlign.right : TextAlign.left,)
                                          ]
                                        ),
                                      ),
                                    ),
                                  subtitleTextStyle: TextStyle() ,
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
                        _messageController.clear();
      
                        setState(() {
                          chatUserData = GetChatlist().execute(id);
                        });
                      },
                      icon: Icon(Icons.send)
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}