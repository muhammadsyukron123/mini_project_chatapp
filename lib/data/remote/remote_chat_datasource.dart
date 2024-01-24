import 'package:http/http.dart' as http;

class RemoteChatDatasource{
  static const URL = 'http://127.0.0.1:8080';

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


}