import 'package:flutter/material.dart';
import 'package:green_gis/Components/LearningMenuCard.dart';
import 'package:green_gis/Pages/LearnAndPlayFeature/LearningDetailPage.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.arrow_back_ios)
              ),
              const Text(
                "Học & Chơi", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1D2D50))
              ),
              const Text(
                "PHÁT TRIỂN BẢN THÂN", 
                style: TextStyle(letterSpacing: 1.2, color: Colors.grey, fontSize: 12)
              ),
              const SizedBox(height: 30),
              // LEARNING CARD
              LearningMenuCard(
                title: "HỌC",
                subtitle: "KIẾN THỨC & QUIZ",
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF00D180),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LearningDetailPage()),
                  );
                },
              ),
              const SizedBox(height: 20),

              LearningMenuCard(
                title: "CHƠI",
                subtitle: "TRÒ CHƠI XANH",
                icon: Icons.sports_esports_rounded,
                color: const Color(0xFF4A80F0),
                onTap: () {
                  print("Chuyển đến trang Game");
                },
              ),
              const SizedBox(height: 20),

              ChallengeCard(
                onTap: () {
                   print("Chuyển đến trang Thử thách");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ChallengeCard({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.orangeAccent], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.bolt, color: Colors.white, size: 40),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("THỬ THÁCH", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("HÀNH ĐỘNG XANH", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}