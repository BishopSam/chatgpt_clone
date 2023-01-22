import 'dart:convert';

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

  Message copyWith({
    String? message,
    MessageType? messageType,
  }) {
    return Message(
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'messageType': messageType.toString(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map, MessageType messageType) {
    return Message(
      message: map['message'] ?? '',
      messageType: messageType
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source, MessageType messageType) => Message.fromMap({'message' : source},  messageType);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Message &&
      other.message == message &&
      other.messageType == messageType;
  }

  @override
  int get hashCode => message.hashCode ^ messageType.hashCode;
}
