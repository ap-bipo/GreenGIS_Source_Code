import 'package:flutter/material.dart';
import 'package:green_gis/Services/Constants/Constants.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class Messages extends StatelessWidget {
  String text;
  bool isUser;
  Messages({super.key, required this.text, required this.isUser});
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? Constants.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: isUser 
          ? Text(text, style: const TextStyle(color: Colors.white, fontSize: 15))
          : MarkdownBody(data: text, styleSheet: MarkdownStyleSheet(p: const TextStyle(color: Color(0xFF1D212D), fontSize: 15))),
      ),
    );
  }
}