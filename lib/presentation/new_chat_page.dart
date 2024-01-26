import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/entities/chat_createroom.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';
import 'package:mini_project_chatapp/presentation/chat_room_page.dart';

import '../domain/usecase/create_chatroom.dart';

class NewChatPage extends StatefulWidget{
  late String senderUser;
  NewChatPage(this.senderUser);

  @override
  State<StatefulWidget> createState() => _NewChatPageState(this.senderUser);
}

class _NewChatPageState extends State<NewChatPage>{
  late String senderUser;
  _NewChatPageState(this.senderUser);

  TextEditingController _newReceiver = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Message'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newReceiver,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',
                      hintText: 'Masukkan username baru disini'
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatroomPage(senderUser))
                        );
                        CreateChatroom().execute(
                          CreateChatRoom(
                              username: senderUser,
                              receiverUsername: _newReceiver.text),
                        );
                      });

                    },
                  icon: Icon(Icons.send_rounded),
                )
              ]
            ),
          )
        ],
      ) ,
    );
  }

}
