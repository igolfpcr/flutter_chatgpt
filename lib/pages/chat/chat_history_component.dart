import 'package:flutter/material.dart';
import 'package:nextflow_chatgpt/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:nextflow_chatgpt/pages/chat/chat_message_balloon_component.dart';

class ChatHistory extends StatelessWidget {
  ChatHistory({super.key});

  ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 205, 133, 223),
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  var messageData = chatController.messages[index];
                  return ChatMessageBalloon(
                      message: messageData.message,
                      isSender: messageData.isSender);
                },
              ),
            ),
            if (chatController.isTyping.value) LinearProgressIndicator()
          ],
        );
      }),
    );
  }
}
