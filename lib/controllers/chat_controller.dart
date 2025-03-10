import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextflow_chatgpt/models/chat_message.dart';

class ChatController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  var messages = <ChatMessage>[
    ChatMessage(message: "สวัสดี เป็นยังไงบ้าง", isSender: true),
    ChatMessage(message: "สบายดี ไปไหนมา", isSender: false),
    ChatMessage(message: "สวรรค์", isSender: true),
  ].obs;

// สร้าง Dio instance สำหรับใช้งานกับ Azure OpenAI
  final Dio _dio = Dio();
  // กำหนด URL และ API Key สำหรับใช้งานกับ Azure OpenAI
  final String _azureOpenAiEndpoint = "";
  final String _apiKey = "";
  var isTyping = false.obs;

  void handleSend() async {
    String inputValue = textEditingController.text;
    print(inputValue);
    if (inputValue.isNotEmpty) {
      messages.add(ChatMessage(message: inputValue, isSender: true));
      print(messages.length);
      textEditingController.clear();

      isTyping.value = true;
      await sendMessageToAzureOpenAI(inputValue);
      isTyping.value = false;
      _autoScroll();
    }
  }

  void _autoScroll() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> sendMessageToAzureOpenAI(String message) async {
    try {
      // ส่งข้อความไปยัง Azure OpenAI แบบ POST method
      final response = await _dio.post(
        // กำหนด URL และ API Key สำหรับใช้งานกับ Azure OpenAI
        _azureOpenAiEndpoint,

        // กำหนด header โดยใช้ key 'api-key' และ value เป็น API Key ที่ได้จาก Azure OpenAI
        options: Options(
          headers: {'Content-Type': 'application/json', 'api-key': _apiKey},
        ),

        // กำหนด body ของ request โดยใช้ข้อความที่ได้จากผู้ใช้
        data: {
          "messages": [
            {
              "role": "system",
              "content":
                  "You are an AI assistant that helps people find information."
            },
            {
              "role": "user",
              "content": message,
            },
          ],
          "temperature": 0.7,
          "max_tokens": 800,
        },
      );

      // ถ้า response สำเร็จ และ status code เป็น 200
      if (response.statusCode == 200) {
        // ดึงข้อความที่ได้จาก response มาแสดงผล
        final responseMessage =
            response.data['choices'][0]['message']['content'];

        // เพิ่มข้อความที่ได้จาก response ไปยัง Chat History
        messages.add(ChatMessage(message: responseMessage, isSender: false));
      } else {
        // ถ้าการทำงานไม่สำเร็จ แสดงข้อความ Error และ status message ที่ได้จาก response
        messages.add(ChatMessage(
            message: 'Error: ${response.statusMessage}', isSender: false));
      }
    } catch (e) {
      // ถ้าเกิดข้อผิดพลาด แสดงข้อความ Error และข้อความที่เกิดข้อผิดพลาด
      messages.add(ChatMessage(message: 'Error: $e', isSender: false));
    }
  }
}
