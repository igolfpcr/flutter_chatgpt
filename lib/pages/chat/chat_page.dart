import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikilu/pages/chat/chat_history_component.dart';
import 'package:wikilu/pages/chat/chat_input_component.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Page"),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.home),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatHistory()),
          SafeArea(child: ChatInput()),
        ],
      ),
    );
  }
}
