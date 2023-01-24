import 'package:bloc/bloc.dart';
import 'package:chatgpt_clone/data/repository/message_repo.dart';
import 'package:chatgpt_clone/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  final MessageRepository messageRepository;
  final SpeechToText stt;
  final TextToSpeech tts;
  GptCubit({
    required this.messageRepository,
    required this.stt,
    required this.tts,
  }) : super(const GptInitial());

  final List<Message> _messages = [];

  void decodeWords() async {
    emit(GptLoading(messages: state.messages, decodedWords: null));
    await stt.listen(
      onResult: (result) {
        if (result.finalResult) {
          final userMessage = Message(
              message: result.toFinal().recognizedWords,
              messageType: MessageType.user);
          _messages.add(userMessage);
          emit(GptSpeechDecoded(
              messages: _messages,
              decodedWords: result.toFinal().recognizedWords));
        }
      },
    );
  }

  void enableSpeech() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      final speechEnabled = await stt.initialize();
      if (speechEnabled) {
        emit(const GptSpeechEnabled());
      }
    } else if (status.isDenied) {
      await Permission.microphone.request();
    }
  }

  void getAiResponse(Message message) async {
    var input = message.message;
    emit(
        GptLoading(messages: state.messages, decodedWords: state.decodedWords));
    try {
      
    var newMessage = await messageRepository.getBotMessage(input);
    debugPrint(newMessage.toString());
    _messages.add(
        Message(message: newMessage.message, messageType: MessageType.bot));
    emit(GptMessageSuccess(
        messages: _messages, decodedWords: state.decodedWords));
    } catch (e) {
      emit(GptErrorState(messages: state.messages, decodedWords: state.decodedWords));
    }
  }

  void speak(String? message) async {
    if (message != null) {
      tts.setVolume(0.7);
      await tts.speak(message);
    }
  }
}
