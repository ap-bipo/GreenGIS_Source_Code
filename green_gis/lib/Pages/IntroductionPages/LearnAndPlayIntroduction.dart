import 'package:flutter/material.dart';
import 'package:green_gis/Components/Button.dart';
import 'package:green_gis/Pages/IntroductionPages/LeaderBoardIntroduction.dart';
import 'package:green_gis/Services/Constants/Constants.dart';

class LearnAndPlayIntroduction extends StatelessWidget {
  const LearnAndPlayIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              const Text(
                "Vừa học vừa chơi\nvới Eco-Game",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B4332), 
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Vừa chơi vừa khám phá kiến thức xanh, giúp bạn xây dựng động lực giảm nhựa bền vững hơn.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // ECOGAME
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D936C), Color(0xFF5DBB8E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5DBB8E).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.stars, color: Colors.amber, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          "CẤP ĐỘ 12",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.videogame_asset, color: Colors.white.withOpacity(0.2), size: 40),
                      ],
                    ),
                    const Text(
                      "Hiệp sĩ Đại dương",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.62,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("1.240 / 2.000 XP", style: TextStyle(color: Colors.white, fontSize: 11)),
                        Text("🪙 450 Eco-Coins", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              // DAILY TASK CARDS
              const Text(
                "NHIỆM VỤ HẰNG NGÀY",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D936C),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),

              _buildMissionItem(
                icon: Icons.track_changes,
                iconColor: Colors.green,
                title: "Đọc 3 mẹo giảm nhựa",
                sub: "+50 XP",
                isCompleted: false,
              ),
              _buildMissionItem(
                icon: Icons.bolt,
                iconColor: Colors.purple,
                title: "Quiz: Nhựa và Đại dương",
                sub: "+100 XP",
                isCompleted: true,
              ),
              const SizedBox(height: 40),
              Button(
                text: "Tiếp theo",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LeaderboardIntroduction()),
                  );
                },
                Size: double.infinity,
                colorBox: Constants.primary,
                colorText: Colors.white,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String sub,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FDF7), 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  sub,
                  style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey.shade300,
            size: 28,
          ),
        ],
      ),
    );
  }
}