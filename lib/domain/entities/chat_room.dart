

class Chatroom{
  String username;
  List<String> rooms;

  Chatroom({required this.username, required this.rooms});

  factory Chatroom.fromJson(Map<String, dynamic> json) {
    return Chatroom(
      username: json['username'] ?? '', // Replace '' with a default value if needed
      rooms: List<String>.from(json['rooms'] ?? []),
    );
  }
}
