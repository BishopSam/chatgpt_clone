part of 'speech_cubit.dart';

abstract class SpeechState extends Equatable {
  const SpeechState({required this.lastWords, required this.speechEnabled});
  final String? lastWords;
  final bool speechEnabled;

  @override
  List<Object> get props => [lastWords ?? "", speechEnabled];
}

class SpeechInitial extends SpeechState {
  const SpeechInitial() : super(lastWords: null, speechEnabled: false);
}
class SpeechEnabled extends SpeechState {
  const SpeechEnabled({required super.speechEnabled}) : super(lastWords: null);
}

class SpeechDecoded extends SpeechState {
  const SpeechDecoded({required super.lastWords}) : super(speechEnabled: true);
}

