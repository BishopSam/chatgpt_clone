import 'package:chatgpt_clone/logic/cubit/speech_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //context.read<SpeechCubit>().enableSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Voice Chat GPT',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Recognized words:',
              style: TextStyle(fontSize: 20.0),
            ),
            BlocConsumer<SpeechCubit, SpeechState>(
              listener: (context, state) {
                // if (state.isListening == true) {
                //   context.read<AppBloc>().add(StopListeningEvent());
                // }
              },
              builder: (context, state) {
                debugPrint(state.lastWords);

                return Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(state.lastWords??"ok" ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SpeechCubit>().decodeWords();
        },
        child: const Icon(Icons.mic),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
