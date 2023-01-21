import 'package:flutter/material.dart';

import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.message, required this.isLoading});
  final Message message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : message.messageType == MessageType.user
              ? UserMessageWidget(message: message.message)
              : BotMessageWidget(message: message.message),
    );
  }
}

class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BotMessageWidget extends StatelessWidget {
  const BotMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
