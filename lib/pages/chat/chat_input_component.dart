import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextflow_chatgpt/controllers/chat_controller.dart';

class ChatInput extends StatelessWidget {
  ChatInput({super.key});

  ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: chatController.textEditingController,
            decoration: InputDecoration(
              hintText: 'กรอกข้อความเพื่อคุยกับเราตรงนี้',
            ),
          )),
          IconButton(
            onPressed: chatController.handleSend,
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
