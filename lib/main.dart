import 'package:chatgpt_clone/logic/cubit/cubit/gpt_cubit.dart';
import 'package:chatgpt_clone/logic/cubit/speech_cubit.dart';
import 'package:chatgpt_clone/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'data/token.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SpeechCubit(
          stt: SpeechToText(),
        ),
      ),
      BlocProvider(
        create: (context) => GptCubit(
            chatGPTApi: ChatGPTApi(
          sessionToken: sessionToken,
          clearanceToken: clearanceToken,
        )),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
