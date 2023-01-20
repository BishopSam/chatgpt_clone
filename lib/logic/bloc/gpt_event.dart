part of 'gpt_bloc.dart';

abstract class GptEvent extends Equatable {
  const GptEvent();

  @override
  List<Object> get props => [];
}

class GptMessageEvent extends GptEvent {
  final Message message;
  const GptMessageEvent({
    required this.message,
  });
}
