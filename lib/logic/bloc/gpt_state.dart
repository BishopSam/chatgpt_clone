part of 'gpt_bloc.dart';

abstract class GptState extends Equatable {
  const GptState();
  
  @override
  List<Object> get props => [];
}

class GptInitial extends GptState {}
