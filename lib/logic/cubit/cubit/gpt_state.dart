part of 'gpt_cubit.dart';

abstract class GptState extends Equatable {
  const GptState({
    required this.messages,
    required this.isLoading,
    required this.speechEnabled,
    required this.userMessageAdded,
  });
  final List<Message>? messages;
  final bool isLoading;
   final bool speechEnabled;
  final bool userMessageAdded;

  @override
  List<Object> get props => [messages ?? [], isLoading, userMessageAdded, speechEnabled];
}

class GptInitial extends GptState {
  const GptInitial() : super(isLoading: false, messages: null, speechEnabled: false, userMessageAdded: false);
}

class GptLoading extends GptState {
  const GptLoading({required super.isLoading, required super.messages, required super.speechEnabled, required super.userMessageAdded});
}



class GptMessageSuccess extends GptState {
  const GptMessageSuccess({required super.messages, required super.speechEnabled, required super.isLoading, required super.userMessageAdded});
}
