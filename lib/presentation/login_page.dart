import 'package:flutter/material.dart';
import 'package:mini_project_chatapp/data/remote/remote_chat_datasource.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatlist.dart';
import 'package:mini_project_chatapp/domain/usecase/get_chatroom.dart';
import 'package:mini_project_chatapp/presentation/chat_room_page.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
  TextEditingController _usernameController = TextEditingController();

  void showEmptyUsernameDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Username tidak boleh kosong'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        }
    );
  }

  void showUsernameNotExistDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Username tidak ada'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        automaticallyImplyLeading: false,
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
                    if(_usernameController.text.isEmpty){
                      showEmptyUsernameDialog(context);
                    } else{
                      try{
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => ChatroomPage(_usernameController.text))
                        );
                      }catch(e){
                        print(e);
                      }
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