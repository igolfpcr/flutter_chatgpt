import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikilu/controllers/chat_controller.dart';
import 'package:wikilu/pages/chat/chat_page.dart';
import 'package:wikilu/pages/home/home_page.dart';

void main() {
  Get.lazyPut(() {
    return ChatController();
  }, fenix: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nextflow ChatGPT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //home: ChatPage(),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/chat', page: () => ChatPage())
      ],
    );
  }
}
