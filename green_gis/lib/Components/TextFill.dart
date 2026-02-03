import 'package:flutter/material.dart';

class TextFill extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool hideText;
  final IconData? icon;
  final Function(String)? onSubmitted;

  const TextFill({
    super.key,
    required this.text,
    required this.controller,
    required this.hideText,
    this.icon,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hideText,
      textInputAction: TextInputAction.send,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        prefixIconColor: Colors.grey,
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