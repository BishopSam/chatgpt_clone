import 'package:flutter/material.dart';

import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.message, required this.isLoading});
  final Message? message;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (message?.message.isNotEmpty ?? false) {
      return Container(
        child: message?.messageType == MessageType.user
            ? UserMessageWidget(message: message?.message ?? "")
            : BotMessageWidget(
                message: message?.message ?? "",
              ),
      );
    }
    return Container();
  }
}

class UserMessageWidget extends StatelessWidget {
  const UserMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                message,
                maxLines: 10,
                // overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BotMessageWidget extends StatelessWidget {
  const BotMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  child: Image.asset(
                    "assets/images/chatgpt.jpeg",
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              // const SizedBox(height: 120,)
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                message,
                // maxLines: 10,
                // overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
