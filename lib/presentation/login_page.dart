

import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/presentation/chat_room_page.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Masukkan username anda disini'
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    try{
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatroomPage(_usernameController.text))
                      );
                    }catch(e){
                      print(e);
                    }
                  });
                },
                child: Text('Login'))
          ],
        ),
      ),
    );  
  }
  
}
