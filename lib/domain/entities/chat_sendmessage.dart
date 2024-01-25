

class ChatSendMessage{
  String id;
  String senderUsername;
  String text;

  ChatSendMessage({required this.id, required this.senderUsername, required this.text});

  factory ChatSendMessage.fromJson(Map<String, dynamic> json) {
    return ChatSendMessage(
      id: json['id'],
      senderUsername: json['username'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : this.id,
      'username' : this.senderUsername,
      'text' : this.text,
    };
  }

}