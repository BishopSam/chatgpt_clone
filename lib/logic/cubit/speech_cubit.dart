import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final SpeechToText stt;
  SpeechCubit(this.stt) : super(const SpeechInitial());

  void decodeWords() async {
    await stt.initialize();
    await stt.listen(
      onResult: (result) {
        emit(SpeechDecoded(words: result.recognizedWords));
      },
    );
  }

  void enableSpeech() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      final speechEnabled = await stt.initialize();
      emit(SpeechEnabled(speech: speechEnabled));
    } else if (status.isDenied) {
      await Permission.microphone.request();
    }
  }
}
