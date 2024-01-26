import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteChatDatasource{
  static const URL = 'http://127.0.0.1:8080';


  // ?dapet roomId
  Future<String> getChatrooms(String username) async{
    var response = await http.get(Uri.parse('${URL}/api/user/${username}'));

    if(response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception('Failed to get chat data');
    }
  }

  Future<String> getChatlist(String id) async{
    var response = await http.get(Uri.parse('${URL}/api/chat/${id}'));

    if(response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception('Failed to get chat data');
    }
  }

  Future<String> postChat(Map<String, dynamic> chat) async {
    var response = await http.post(
      Uri.parse('${URL}/api/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': chat['id'],
        'from': chat['username'],
        'text': chat['text'],
      }),
    );

    print(response.body);

    return response.body;
  }

  Future<String> createChatRoom(Map<String, dynamic> room) async{
    var response = await http.post(
      Uri.parse('${URL}/api/room'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'from': room['from'],
        'to': room['to'],
      }),
    );

    print('Ini response bodynya createchatroom ${response.body}<<<<<<');

    return response.body;
  }



}