import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double Size;
  final Color colorBox;
  final Color colorText;
  final Function()? onTap;

  const Button({
    super.key,
    required this.text,
    required this.Size,
    required this.colorBox,
    required this.colorText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Size,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBox, 
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
