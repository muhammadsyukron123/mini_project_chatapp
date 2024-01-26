

class CreateChatRoom{
  var username;
  var receiverUsername;

  CreateChatRoom({required this.username, required this.receiverUsername});

  factory CreateChatRoom.fromJson(Map<String, dynamic> json) {
    return CreateChatRoom(
      username: json['from'],
      receiverUsername: json['to'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'from' : username,
      'to' : receiverUsername,
    };
  }

}