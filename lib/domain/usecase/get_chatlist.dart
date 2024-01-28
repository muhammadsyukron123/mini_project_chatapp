
import 'package:mini_project_chatapp/data/repository/chatlist_repository.dart';
import 'package:mini_project_chatapp/domain/entities/chat_user_list.dart';

class GetChatlist{
  var repository = ChatUserlistRepository();

  Future<ChatuserList> execute(String id){
    return repository.getChatuserList(id);
    
    
  }

}