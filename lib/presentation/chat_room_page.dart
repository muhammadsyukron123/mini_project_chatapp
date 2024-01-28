import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/entities/chat_room.dart';
import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/presentation/chat_page.dart';
import 'package:mini_project_chatapp/presentation/new_chat_page.dart';

import 'login_page.dart';

class ChatroomPage extends StatefulWidget{
  late String username;
  ChatroomPage(this.username);

  @override
  State<StatefulWidget> createState() => _ChatroomPageState(username);

}

class _ChatroomPageState extends State<ChatroomPage>{
  late Future<List<String>> chatRoom;

  _ChatroomPageState(String username);


  void showConfirmLogoutDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm Logout'),
            content: Text('Do you want to logout?'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                  child: Text('OK')),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        }
    );
  }


  @override
  void initState() {
    GetChatlist().execute(widget.username);
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
        title: Align(alignment: Alignment.center,child: Text('Chatroom')),
          automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  showConfirmLogoutDialog(context);
                });
              },
              icon: Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              chatRoom = GetChatroom().execute(widget.username).then(
                      (chatRoomsData) {
                    return chatRoomsData.rooms;
                  });
            });
          },
          child: FutureBuilder<Chatroom>(
            future: GetChatroom().execute(widget.username),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData){
                return Center(child: Text('Error loading chatroom'));
              } else{
                final user = snapshot.data!;
                return ListView.builder(
                  itemCount: user.rooms.length,
                  itemBuilder: (context, index) {
                    final roomId = user.rooms[index];
                    print('INI DEBUGGING 3 ${roomId}');
                    return FutureBuilder<ChatuserList>(
                      future: GetChatlist().execute(roomId),
                      builder: (context, snapshot) {
                        print('INI DEBUGGING 2 ${snapshot}');
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            title: Text(roomId),
                            subtitle: Text('Loading...'),
                            onTap: () {
                              // Handle onTap as needed
                            },
                          );
                        } else if (snapshot.hasError) {
                          print('Error loading chat room data for room $roomId: ${snapshot.error}');
                          return ListTile(
                            title: Text(roomId),
                            subtitle: Text('Error loading chat room data'),
                            onTap: () {
                              // Handle onTap as needed
                            },
                          );
                        } else if (!snapshot.hasData) {
                          print('No data available for chat room $roomId');
                          return ListTile(
                            title: Text(roomId),
                            subtitle: Text('No data available for chat room'),
                            onTap: () {
                              // Handle onTap as needed
                            },
                          );
                        } else {
                          final chatUserlist = snapshot.data!;
                          final receiverUser = chatUserlist.usernames.where((username) => username != widget.username).toList();
                          final senderUser = widget.username;
                          final receiverSlicedUser = receiverUser.map((username) => username).join(', ');
                          final chatMessage = chatUserlist.messages;

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                  child: Text(
                                      receiverSlicedUser.isNotEmpty ? receiverSlicedUser[0].toUpperCase() : '?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,)
                                  )
                              ),
                              title: Text('${receiverSlicedUser}', style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: chatMessage.isNotEmpty ? Text('${chatMessage.last.text}') : Text(''),
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ChatPage('${receiverSlicedUser}', roomId, senderUser))
                                  );
                                });
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          final senderUser = widget.username;
              setState(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NewChatPage(senderUser))
              );   
          });
        } ,
        child: Icon(Icons.add_comment_outlined),
      ),
    );
  }


}
