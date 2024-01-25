import 'package:flutter/material.dart';

class NewChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage>{
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
            child: TextField(
              controller: _newReceiver,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'username',
                hintText: 'Masukkan username baru disini'
              ),
            ),
          )
        ],
      ) ,
    );
  }

}
