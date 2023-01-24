part of 'gpt_cubit.dart';

abstract class GptState extends Equatable {
  const GptState({
    required this.messages,
    required this.decodedWords,
  });
  final List<Message>? messages;
  final String? decodedWords;

  @override
  List<Object> get props => [messages ?? [], decodedWords ?? ""];
}

class GptInitial extends GptState {
  const GptInitial() : super(messages: null, decodedWords: null);
}

class GptLoading extends GptState {
  const GptLoading({required super.messages, required super.decodedWords});
}

class GptErrorState extends GptState {
  const GptErrorState({required super.messages, required super.decodedWords});
}

class GptMessageSuccess extends GptState {
  const GptMessageSuccess(
      {required super.messages, required super.decodedWords});
}

class GptSpeechEnabled extends GptState {
  const GptSpeechEnabled() : super(messages: null, decodedWords: null);
}

class GptSpeechDecoded extends GptState {
  const GptSpeechDecoded(
      {required super.messages, required super.decodedWords});
}


