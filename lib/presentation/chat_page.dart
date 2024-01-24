
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('user: x'),
      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: ListView(
              padding: EdgeInsets.all(8.0) ,
              children: [],
            ),
          ),
          Expanded(
              child: Row(
                children: [
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message'
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                      onPressed: (){

                      },
                      child: Text('Send'))
                ],
              )
          )
        ],
      ),
    );
  }

}