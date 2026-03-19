import 'package:flutter/material.dart';
import 'ProofCaptureScreen.dart';

class ChallengeListScreen extends StatelessWidget {
  const ChallengeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF5),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  _buildChallengeCard(
                    context,
                    icon: Icons.water_drop,
                    iconColor: Colors.lightBlue,
                    iconBgColor: Colors.lightBlue.withOpacity(0.2),
                    timeTag: '24 giờ',
                    title: '24h nói không với ống hút',
                    description:
                        'Thử nghiệm phong cách uống nước "trực tiếp" hoặc dùng ống hút cá nhân để bảo...',
                    buttonText: 'Chấp nhận thử thách',
                    buttonColor: const Color(0xFF22B07D),
                  ),
                  const SizedBox(height: 20),
                  _buildChallengeCard(
                    context,
                    icon: Icons.local_cafe_outlined,
                    iconColor: const Color(0xFF22B07D),
                    iconBgColor: const Color(0xFF22B07D).withOpacity(0.2),
                    timeTag: '3 ngày liên tiếp',
                    title: 'Bình nước riêng - Phong cách riêng',
                    description:
                        'Thay thế hoàn toàn chai nước suối nhựa bằng bình cá nhân tại trường để giảm...',
                    buttonText: 'Bắt đầu Streak',
                    buttonColor: const Color(0xFF22B07D),
                  ),
                  const SizedBox(height: 20),
                  _buildChallengeCard(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    iconColor: Colors.orange,
                    iconBgColor: Colors.orange.withOpacity(0.2),
                    timeTag: 'Trong buổi sáng hôm nay',
                    title: 'Hộp cơm cá nhân - Bữa sáng xanh',
                    description:
                        'Từ chối hộp xốp và túi nilon khi mua đồ ăn sáng trước cổng trường để bắt đầu ngày...',
                    buttonText:
                        null, // No button for this state in the UI image
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // Optional: Add simple bottom bar to match mockups slightly if needed globally
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF1B4332),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thử thách',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hành Động Xanh Ngay Hôm Nay',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String timeTag,
    required String title,
    required String description,
    String? buttonText,
    Color? buttonColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background abstract shape (mimicking the UI)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: iconBgColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(150),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: iconColor, size: 28),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        timeTag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                if (buttonText != null) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProofCaptureScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            buttonText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
