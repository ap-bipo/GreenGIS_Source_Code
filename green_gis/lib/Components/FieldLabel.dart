import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final double spaceVal;
  const FieldLabel({super.key, required this.label, required this.spaceVal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spaceVal),
      child: Text(
        label, 
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      )
    );
  }
}
