
class ChatMessage{
  String username;
  String text;
  var timestamp;

  ChatMessage({required this.username, required this.text, required this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      username: json['username'],
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }

}
