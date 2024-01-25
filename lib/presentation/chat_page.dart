
import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';

class ChatPage extends StatefulWidget {
  late String username;
  late String id;

  ChatPage(this.username, this.id);

  @override
  State<StatefulWidget> createState() => _ChatPageState(this.username, this.id);
}

class _ChatPageState extends State<ChatPage> {
  late String username;
  late String id;
  TextEditingController _messageController = TextEditingController();

  _ChatPageState(this.username, this.id);

  @override
  void initState() {
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
            child: FutureBuilder(
                future: GetChatlist().execute(id),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text(id),
                      subtitle: Text('Loading...'),
                      onTap: () {
                        // Handle onTap as needed
                      },
                    );
                  } else if (snapshot.hasError) {
                    print('Error loading chat room data for room $id: ${snapshot.error}');
                    return ListTile(
                      title: Text(id),
                      subtitle: Text('Error loading chat room data'),
                      onTap: () {
                        // Handle onTap as needed
                      },
                    );
                  } else if (!snapshot.hasData) {
                    print('No data available for chat room $id');
                    return ListTile(
                      title: Text(id),
                      subtitle: Text('No data available for chat room'),
                      onTap: () {
                        // Handle onTap as needed
                      },
                    );
                  } else {
                    final chatUserlist = snapshot.data!;
                    final receiverUser = chatUserlist.usernames.where((username) => username != widget.username).toList();
                    final receiverSlicedUser = receiverUser.map((username) => username).join(', ');
                    final chatMessage = chatUserlist.messages;

                    return ListTile(
                      leading: CircleAvatar(
                          child: Text(
                              receiverSlicedUser.isNotEmpty ? receiverSlicedUser[0].toUpperCase() : '?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,)
                          )
                      ),
                      title: Text('${receiverSlicedUser}', style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('${chatMessage[]}'),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChatPage('${receiverSlicedUser}', roomId))
                        );
                      },
                    );
                  }
                })
          ),
          Row(
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
              OutlinedButton(
                  onPressed: (){

                  },
                  child: Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }
}
