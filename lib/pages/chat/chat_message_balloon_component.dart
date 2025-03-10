import 'package:flutter/material.dart';

class ChatMessageBalloon extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatMessageBalloon({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    Color? color;
    Alignment? align;

    if (isSender) {
      color = Colors.blue[200];
      align = Alignment.centerRight;
    } else {
      color = Colors.green[200];
      align = Alignment.centerLeft;
    }

    return Align(
      alignment: align,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message),
      ),
    );
  }
}
