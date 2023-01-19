part of 'speech_cubit.dart';

abstract class SpeechState extends Equatable {
  const SpeechState({required this.lastWords, required this.speechEnabled});
  final String? lastWords;
  final bool speechEnabled;

  @override
  List<Object> get props => [];
}

class SpeechInitial extends SpeechState {
  const SpeechInitial() : super(lastWords: null, speechEnabled: false);
}

class SpeechDecoded extends SpeechState {
final String words;
 const SpeechDecoded({required this.words}) : super(speechEnabled: true, lastWords: words);

 @override
  List<Object> get props => [words];
}

class SpeechEnabled extends SpeechState {
  final bool speech;
 const SpeechEnabled({required this.speech}) : super(lastWords: null, speechEnabled: speech);

@override
  List<Object> get props => [speech];
  
}
