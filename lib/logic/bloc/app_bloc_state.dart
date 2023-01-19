part of 'app_bloc_bloc.dart';

class SpeechState extends Equatable {
  final bool isLoading;
  final bool speechEnabled;
  final String? lastWords;
  final bool? isListening;

  const SpeechState({
    required this.isLoading,
    required this.speechEnabled,
    required this.lastWords,
    required this.isListening,
  });

  const SpeechState.empty()
      : isLoading = false,
        speechEnabled = false,
        isListening = null,
        lastWords =null;

  @override
  String toString() {
    return 'SpeechState(isLoading: $isLoading, speechEnabled: $speechEnabled, lastWords: $lastWords, isListening: $isListening)';
  }

  @override
  List<Object?> get props => [isListening, isLoading, lastWords, speechEnabled];

  SpeechState copyWith({
    bool? isLoading,
    bool? speechEnabled,
    String? lastWords,
    bool? isListening,
  }) {
    return SpeechState(
      isLoading: isLoading ?? this.isLoading,
      speechEnabled: speechEnabled ?? this.speechEnabled,
      lastWords: lastWords ?? this.lastWords,
      isListening: isListening ?? this.isListening,
    );
  }
}
