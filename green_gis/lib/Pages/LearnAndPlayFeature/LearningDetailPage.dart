import 'package:flutter/material.dart';
import 'package:green_gis/Pages/LearnAndPlayFeature/TopicSelectionPage.dart';
import 'package:green_gis/Components/LearningOption.dart';

class LearningDetailPage extends StatelessWidget {
  const LearningDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Học tập",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1D2D50)),
            ),
            const Text(
              "Lộ trình xanh của bạn",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 32),
            LearningOption(
              title: "Chủ đề học tập",
              subtitle: "Kiến thức từ cơ bản đến nâng cao",
              icon: Icons.bar_chart_rounded,
              iconColor: const Color(0xFF00D180),
              onTap: () {
              },
            ),    
            LearningOption(
              title: "Flashcards",
              subtitle: "Ghi nhớ nhanh các khái niệm",
              icon: Icons.layers_rounded,
              iconColor: const Color(0xFF4A80F0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TopicSelectionPage()),
                );
              },
            ),
            LearningOption(
              title: "Mini Quiz",
              subtitle: "Kiểm tra kiến thức tức thì",
              icon: Icons.help_outline_rounded,
              iconColor: const Color(0xFFFF9800),
              onTap: () {
              },
            ),
            
            LearningOption(
              title: "Thư viện xanh",
              subtitle: "Tài liệu tham khảo tổng hợp",
              icon: Icons.book_outlined,
              iconColor: const Color(0xFF9C27B0),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }

  
}