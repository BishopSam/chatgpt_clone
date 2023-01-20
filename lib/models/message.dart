enum MessageType{ 
  bot,
  user
}

class Message {
  final String message;
  final MessageType messageType;
  Message({
    required this.message,
    required this.messageType,
  });

  @override
  String toString() => 'Message(message: $message, messageType: $messageType)';
}
