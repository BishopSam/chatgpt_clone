import 'package:chatgpt_clone/logic/cubit/cubit/gpt_cubit.dart';
import 'package:chatgpt_clone/logic/cubit/speech_cubit.dart';
import 'package:chatgpt_clone/models/message.dart';
import 'package:chatgpt_clone/presentation/widgets/message_widget.dart';
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
    context.read<SpeechCubit>().enableSpeech();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SpeechCubit, SpeechState>(
      listener: (context, state) {
        if (state is SpeechDecoded) {
          if (state.lastWords?.isNotEmpty ?? false) {
            context.read<GptCubit>().addMessage(Message(
                message: state.lastWords ?? "", messageType: MessageType.user));
          }
        }
      },
      child: Scaffold(
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
              BlocBuilder<GptCubit, GptState>(
                builder: (context, state) {
                  debugPrint(state.messages?.toString());
                  if (state.messages != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: SizedBox(
                        height: size.height * 0.9,
                        child: ListView.builder(
                          itemCount: state.messages?.length,
                          itemBuilder: (context, index) {
                            final isLoading = state is GptLoading;

                            return MessageWidget(
                                message: state.messages?[index],
                                isLoading: isLoading);
                          },
                        ),
                      ),
                    );
                  }
                  return const Text("Test");
                },
              ),
            ],
          ),
        ),
        floatingActionButton:
            BlocBuilder<GptCubit, GptState>(builder: (context, state) {
          debugPrint(state.toString());
          return FloatingActionButton(
            onPressed: state is GptLoading
                ? null
                : () {
                    context.read<SpeechCubit>().decodeWords();
                  },
            child: state is GptLoading
                ? CircularProgressIndicator(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    color: Colors.white,
                  )
                : const Icon(Icons.mic),
          );
        }),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
