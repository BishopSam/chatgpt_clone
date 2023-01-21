import 'package:chatgpt_clone/data/repository/open_ai_api.dart';
import 'package:chatgpt_clone/models/message.dart';

class MessageRepository {
  final OpenAiCompletionApi api;
  MessageRepository({
    required this.api,
  });
  
  Future<Message> getBotMessage(String userMessage) async {
    final String rawBotMessage = await api.complete(userMessage);
    final Message message = Message.fromJson(rawBotMessage, MessageType.bot);
    return message;
  }
}
