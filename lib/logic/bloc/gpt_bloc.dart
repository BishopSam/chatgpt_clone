import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatgpt_clone/logic/cubit/speech_cubit.dart';
import 'package:chatgpt_clone/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

part 'gpt_event.dart';
part 'gpt_state.dart';

class GptBloc extends Bloc<GptEvent, GptState> {
  final ChatGPTApi chatGPTApi;
  GptBloc({required this.chatGPTApi}) : super(GptInitial()) {
    on<GptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
