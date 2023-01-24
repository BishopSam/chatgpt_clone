part of 'gpt_cubit.dart';

abstract class GptState extends Equatable {
  const GptState({
    required this.messages,
    required this.decodedWords,
    required this.errorMessage, 
  });
  final List<Message>? messages;
  final String? decodedWords;
  final String? errorMessage;

  @override
  List<Object> get props => [messages ?? [], decodedWords ?? "", errorMessage ?? ""];
}

class GptInitial extends GptState {
  const GptInitial() : super(messages: null, decodedWords: null, errorMessage: null);
}

class GptLoading extends GptState {
  const GptLoading({required super.messages, required super.decodedWords}) : super(errorMessage: null);
}

class GptErrorState extends GptState {
  const GptErrorState({required super.messages, required super.decodedWords, required super.errorMessage});
}

class GptMessageSuccess extends GptState {
  const GptMessageSuccess(
      {required super.messages, required super.decodedWords}) :super (errorMessage: null);
}

class GptSpeechEnabled extends GptState {
  const GptSpeechEnabled() : super(messages: null, decodedWords: null, errorMessage: null);
}

class GptSpeechDecoded extends GptState {
  const GptSpeechDecoded(
      {required super.messages, required super.decodedWords}) : super(errorMessage: null);
}


