part of 'app_bloc_bloc.dart';

@immutable
abstract class AppEvent extends Equatable{}


class EnableSpeechEvent extends AppEvent {
   EnableSpeechEvent();
   
     @override
     List<Object?> get props => [];
}

class StartListeningEvent extends AppEvent{
  StartListeningEvent();
   @override
     List<Object?> get props => [];
}

class StopListeningEvent extends AppEvent{
  StopListeningEvent();
   @override
     List<Object?> get props => [];
}

