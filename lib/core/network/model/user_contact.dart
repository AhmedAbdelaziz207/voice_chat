class UserContact {
  UserContact({this.name, this.imageUrl});

  final String? name;

  final String? imageUrl;

  String lastSeen = "Online";

  int senderId = 1;

  final List<ChatMessage> chatMessages = [];
}

class ChatMessage {
  late DateTime messageDateTime;

  late String messageTime;

  late Record record;
}
