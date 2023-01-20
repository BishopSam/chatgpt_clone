import 'package:bloc/bloc.dart';
import 'package:chatgpt_clone/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  final ChatGPTApi chatGPTApi;

  GptCubit({
    required this.chatGPTApi,
  }) : super(const GptInitial());

    List<Message> _messages = [];
  void addMessage(Message message) async {
    emit(GptLoading(
        isLoading: true,
        messages: null,
        speechEnabled: state.speechEnabled,
        userMessageAdded: false));
    _messages.add(message);
   // debugPrint(messages.toString());
    emit(GptMessageSuccess(
        messages: _messages,
        speechEnabled: state.speechEnabled,
        isLoading: false,
        userMessageAdded: true));
    var input = message.message;
    emit(GptLoading(
        isLoading: true,
        messages: state.messages,
        speechEnabled: state.speechEnabled,
        userMessageAdded: state.userMessageAdded));

    try {
      var newMessage = await chatGPTApi.sendMessage(input);
      _messages.add(
          Message(message: newMessage.message, messageType: MessageType.bot));
      emit(GptMessageSuccess(
          messages: _messages,
          speechEnabled: state.speechEnabled,
          isLoading: false,
          userMessageAdded: false));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getBotMessage() {}
}
