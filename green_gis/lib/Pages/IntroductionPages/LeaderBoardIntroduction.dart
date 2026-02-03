import 'package:flutter/material.dart';
import 'AIBuddyIntroduction.dart';

class LeaderboardIntroduction extends StatelessWidget {
  const LeaderboardIntroduction({super.key});

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
      body: SafeArea(
        child: Column(
          children: [
            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thi đua lớp –\nChung tay giảm nhựa',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kết nối với bạn bè cùng lớp, thi đua giảm nhựa để đưa lớp mình lên top bảng xếp hạng trường.',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[200]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1FAF5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outline, color: Color(0xFF1B4332)),
                            SizedBox(width: 8),
                            Text('BXH Khối 12', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                          ],
                        ),
                        Icon(Icons.emoji_events_outlined, color: Color(0xFF5DBB8E)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _buildRankItem("01", "Lớp 12A3", "256 thành viên", "25.5kg", false),
                    _buildRankItem("02", "Lớp 12A1 (Bạn)", "Sắp đuổi kịp 12A3!", "24.5kg", true),
                    _buildRankItem("03", "Lớp 12A5", "240 thành viên", "19.4kg", false),
                    
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFFD1F2E1), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.trending_up, color: Color(0xFF5DBB8E)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Lớp bạn đã tăng 2 bậc so với tuần trước. Cùng cố gắng nhé!',
                            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AIBuddyIntroduction()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5DBB8E),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  shadowColor: const Color(0xFF5DBB8E).withOpacity(0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tiếp theo', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildRankItem(String rank, String title, String subTitle, String weight, bool isHighlighted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted ? Border.all(color: const Color(0xFF5DBB8E), width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Text(rank, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[400])),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B4332))),
                Text(subTitle, style: TextStyle(fontSize: 12, color: isHighlighted ? const Color(0xFF5DBB8E) : Colors.grey[400])),
              ],
            ),
          ),
          Text(weight, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF5DBB8E))),
        ],
      ),
    );
  }
}