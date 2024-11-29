import 'package:flutter/material.dart';
import '../../data/models/message_model.dart';
import 'message_bubble.dart';

class ChatMessageList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Message> messages;
  final Function(String)? onSuggestionTap;

  const ChatMessageList({
    Key? key,
    required this.scrollController,
    required this.messages,
    this.onSuggestionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      reverse: false,
      padding: EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(
          message: messages[index],
          onSuggestionTap: onSuggestionTap,
        );
      },
    );
  }
}