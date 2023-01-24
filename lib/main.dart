import 'package:chatgpt_clone/data/repository/message_repo.dart';
import 'package:chatgpt_clone/data/repository/open_ai_api.dart';
import 'package:chatgpt_clone/presentation/home_screen.dart';
import 'package:chatgpt_clone/presentation/logic/cubit/gpt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

import 'data/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  runApp(BlocProvider(
    create: (context) => GptCubit(
      messageRepository: MessageRepository(api: OpenAiCompletionApi(apiKey)),
      stt: SpeechToText(),
      tts: TextToSpeech(),
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Chat GPT',
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.montserrat(fontSize: 14),
              titleLarge: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.bold))),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
