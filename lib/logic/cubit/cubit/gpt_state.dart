part of 'gpt_cubit.dart';

abstract class GptState extends Equatable {
  const GptState({
    required this.messages,
   
  });
  final List<Message>? messages;
 
 


  @override
  List<Object> get props => [messages ?? []];
}

class GptInitial extends GptState {
  const GptInitial() : super( messages: null,);
}

class GptLoading extends GptState {
  const GptLoading({ required super.messages});
}

class GptErrorState extends GptState{
  const GptErrorState({required super.messages});
}

class GptMessageSuccess extends GptState {
  const GptMessageSuccess({required super.messages});
}
