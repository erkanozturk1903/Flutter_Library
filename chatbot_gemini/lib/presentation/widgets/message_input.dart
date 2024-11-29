import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final VoidCallback onVoiceInput;
  final VoidCallback onImageUpload;

  const MessageInput({
    Key? key,
    required this.controller,
    required this.onSend,
    required this.onVoiceInput,
    required this.onImageUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: onVoiceInput,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Mesajınızı yazın...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: onImageUpload,
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSend(controller.text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}