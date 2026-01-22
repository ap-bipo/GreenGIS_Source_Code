import 'package:flutter/material.dart';

class TextFill extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool hideText;
  const TextFill({
    super.key,
    required this.text,
    required this.controller,
    required this.hideText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 33, 94, 144),
            width: 2,
          ),
        ),    
      ),
    );
  }
}
