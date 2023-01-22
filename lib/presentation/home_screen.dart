import 'package:chatgpt_clone/logic/cubit/gpt_cubit.dart';
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
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GptCubit>().enableSpeech();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Voice Chat GPT',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BlocConsumer<GptCubit, GptState>(
            listener: (context, state) {
              if (state is GptSpeechDecoded) {
                if (state.decodedWords != null) {
                  context.read<GptCubit>().getAiResponse(Message(
                      message: state.decodedWords ?? "",
                      messageType: MessageType.user));
                }
              }
            },
            builder: (context, state) {
              debugPrint(state.messages?.toString());
              if (state.messages != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: size.height * 0.87,
                    child: ListView.builder(
                      itemCount: state.messages?.length,
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final isLoading = state is GptLoading;
                        if (state.messages?[index].messageType ==
                            MessageType.bot) {
                          _scrollDown();
                        }
                        return MessageWidget(
                            message: state.messages?[index],
                            isLoading: isLoading);
                      },
                    ),
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Tap the mic to start speaking..",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton:
          BlocBuilder<GptCubit, GptState>(builder: (context, state) {
        debugPrint(state.toString());
        return FloatingActionButton(
          onPressed: state is GptLoading
              ? null
              : () {
                  context.read<GptCubit>().decodeWords();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
