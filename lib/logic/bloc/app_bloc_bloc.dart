import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBloc extends Bloc<AppEvent, SpeechState> {
  final SpeechToText stt;
  AppBloc({required this.stt}) : super(const SpeechState.empty()) {
    on<EnableSpeechEvent>((event, emit) async {
      emit(state.copyWith(
          isLoading: true,
          speechEnabled: false,
          lastWords: null,
          isListening: false));
      var status = await Permission.microphone.status;
      if (status.isGranted) {
        final speechEnabled = await stt.initialize();
        emit(state.copyWith(
            isLoading: false,
            speechEnabled: speechEnabled,
            lastWords: null,
            isListening: false));
      } else if (status.isDenied) {
        await Permission.microphone.request();
      }
    });

    on<StartListeningEvent>((event, emit) async {
      //state.lastWords = "";

      emit(state.copyWith(
          isLoading: true,
          speechEnabled: state.speechEnabled,
          lastWords: null,
          isListening: false));
      if (state.speechEnabled == true) {
        await _lastWords();
        emit(state.copyWith(
          isListening: false,
          isLoading: false,
          speechEnabled: true,
          lastWords: words,
        ));
        debugPrint(words);
      }
    });

    on<StopListeningEvent>((event, emit) async {
      emit(
        SpeechState(
          isLoading: true,
          speechEnabled: state.speechEnabled,
          lastWords: "lastWords",
          isListening: false,
        ),
      );
      // await stt.stop();
      // emit(
      //   state.copyWith(
      //       isLoading: false,
      //       speechEnabled: state.speechEnabled,
      //       lastWords: state.lastWords,
      //       isListening: false),
      // );
    });
  }

  var words = '';

  Future<String> _lastWords() async{
    
      await stt.listen(
          onResult: (result) {
           words =  result.recognizedWords;
        });
    return words;
  }
}
