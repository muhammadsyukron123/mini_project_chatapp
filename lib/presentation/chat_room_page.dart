import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';
import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/presentation/chat_page.dart';

class ChatroomPage extends StatefulWidget{
  late String username;
  ChatroomPage(this.username);

  @override
  State<StatefulWidget> createState() => _ChatroomPageState(username);

}

class _ChatroomPageState extends State<ChatroomPage>{
  late Future<List<String>> chatRoom;

  _ChatroomPageState(String username);


  @override
  void initState() {
    chatRoom = GetChatroom().execute(widget.username).then(
            (chatRoomsData) {
              return chatRoomsData.rooms;
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatroom'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<Chatroom>(
          future: GetChatroom().execute(widget.username),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData){
              return Center(child: Text('Error loading chatroom'));
            } else{
              final user = snapshot.data!;
              final roomIds = snapshot.data!.rooms;
              return ListView.builder(
                itemCount: roomIds.length,
                itemBuilder: (context, index) {
                  final roomId = roomIds[index];
                  return FutureBuilder(
                      future: GetChatlist().execute(roomId),
                      builder: (context, snapshot){
                        print(snapshot);
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return ListTile(
                            title: Text('${roomId}'),
                            subtitle: Text('loading'),
                          );
                        } else if (snapshot.hasError || !snapshot.hasData){
                          return ListTile(
                            title: Text('${roomId}'),
                            subtitle: Text('disini error sih ${snapshot.hasError}'),
                          );
                        }else{
                          return ListView.builder(
                              itemCount: roomId.length,
                              itemBuilder: (context, index){
                                final chatList = snapshot.data!;
                                final receiverUser = chatList.users.where((user) => user.username != widget.username);
                                return ListTile(
                                  title: Text(roomId),
                                  subtitle: Text('Receiver: ${receiverUser.map((user) => user.username).join(', ')}'),
                                  onTap:(){

                                  }
                                );
                              });
                        }
                      });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
