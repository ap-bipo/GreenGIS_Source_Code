
import 'package:flutter/material.dart';
import './FlashcardData.dart';

class Topic {
  final int id; 
  final String title;
  final IconData icon;
  final Color color;
  final double progress;
  final List<FlashcardData> cards;

  Topic({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.progress,
    required this.cards,
  });

  factory Topic.fromSupabase(Map<String, dynamic> map, List<FlashcardData> cards) {
    return Topic(
      id: map['id'],
      title: map['title'],
      icon: _parseIcon(map['icon_name']),
      color: Color(int.parse(map['color_hex'], radix: 16)),
      progress: (map['progress'] as num).toDouble(),
      cards: cards,
    );
  }

  static IconData _parseIcon(String? name) {
    switch (name) {
      case 'recycling': return Icons.recycling;
      case 'nature_people': return Icons.nature_people;
      case 'co2': return Icons.co2;
      case 'wb_sunny': return Icons.wb_sunny;
      default: return Icons.eco;
    }
  }
}