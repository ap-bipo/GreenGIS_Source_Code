import 'package:flutter/material.dart';
import 'package:green_gis/Services/Users/Users.dart';
import 'package:green_gis/Pages/HomePage.dart';

class AIBuddyIntroduction extends StatelessWidget {
  final Users users = Users();
  AIBuddyIntroduction({super.key});

  Future<void> finishForm(BuildContext context) async{
    users.updateOnBoardingStatus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF5DBB8E), size: 30),
                  const SizedBox(width: 8),
                  Text(
                    'GreenGIS',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.grey[800]
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, size: 16, color: Color(0xFF5DBB8E)),
                  SizedBox(width: 6),
                  Text(
                    'PERSONALIZED',
                    style: TextStyle(
                      color: Color(0xFF5DBB8E),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Gợi ý AI\ndành riêng cho bạn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'AI cá nhân hóa hành trình sống xanh dựa trên thói quen hằng ngày của bạn.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFD1F2E1), width: 2),
                  ),
                  child: const Icon(Icons.smart_toy_outlined, size: 50, color: Color(0xFF5DBB8E)),
                ),
                const Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(Icons.auto_awesome, color: Color(0xFF5DBB8E), size: 30),
                )
              ],
            ),
            
            const SizedBox(height: 10),
            Text(
              'DỮ LIỆU ĐƯỢC BẢO MẬT BỞI AI',
              style: TextStyle(fontSize: 10, color: Colors.grey[400], letterSpacing: 1),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5DBB8E), Color(0xFF4A9B78)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5DBB8E).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome_sharp, color: Colors.white.withOpacity(0.7), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'AI ASSISTANT',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '"Minh Anh ơi, dựa vào lịch học hôm nay bạn có tiết thể dục. Đừng quên mang bình nước cá nhân để tránh mua chai nhựa SUP ở canteen nhé!"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ElevatedButton(
                onPressed: () async => finishForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5DBB8E),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Xong', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}