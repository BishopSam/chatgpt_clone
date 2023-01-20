
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final SpeechToText stt;
 
  SpeechCubit({required this.stt,}) : super(const SpeechInitial());

  void decodeWords() async {
    await stt.listen(
      onResult: (result) {
        emit(SpeechDecoded(lastWords: result.recognizedWords));
      },
    );
  }

  void enableSpeech() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      final speechEnabled = await stt.initialize();
      emit(SpeechEnabled(speechEnabled: speechEnabled));
    } else if (status.isDenied) {
      await Permission.microphone.request();
    }
  }
}
