import 'package:bloc/bloc.dart';
import 'package:chatgpt_clone/data/repository/message_repo.dart';
import 'package:chatgpt_clone/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  final MessageRepository messageRepository;

  GptCubit({
    required this.messageRepository,
  }) : super(const GptInitial());

  final List<Message> _messages = [];
  void addMessage(Message message) async {
    emit(const GptLoading(
      messages: null,
    ));
    _messages.add(message);
    // debugPrint(messages.toString());
    emit(GptMessageSuccess(
      messages: _messages,
    ));
    var input = message.message;
    emit(GptLoading(
      messages: state.messages,
    ));

    try {
      var newMessage = await messageRepository.getBotMessage(input);
      _messages.add(
          Message(message: newMessage.message, messageType: MessageType.bot));
      emit(GptMessageSuccess(
        messages: _messages,
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getBotMessage() {}
}
