import 'package:flutter/material.dart';
import 'package:green_gis/Pages/AIBuddyFeature.dart/AIBuddyPage.dart';
import 'package:green_gis/Pages/IntroductionPages/TrackingFeatureIntroduction.dart';
import 'LearnAndPlayFeature/LearningPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages = [
    buildHomeMainContent(),       
    const LearningPage(),  
    const AIBuddyPage(),  
    const TrackingFeatureIntroduction(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {

          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 5,
          child: Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8F5E9),
            ),
            child: const Icon(Icons.add_circle, color: Color(0xFF5DBB8E), size: 55),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_filled, "Trang chủ", 0),
              buildNavItem(Icons.videogame_asset_outlined, "Học & Chơi", 1),
              const SizedBox(width: 40), 
              buildNavItem(Icons.smart_toy_outlined, "AI Buddy", 2),
              buildNavItem(Icons.bar_chart_rounded, "Thống kê", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHomeMainContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTopBar(),
            const SizedBox(height: 30),
            const Text(
              'Chào Minh Anh 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1B4332)),
            ),
            const SizedBox(height: 8),
            Text(
              'Cùng gieo mầm xanh cho lớp mình nhé!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(height: 25),
            buildScoreCard(), 
            const SizedBox(height: 30),
            buildDailyProgress(),
            const SizedBox(height: 20),
            buildMissionCard(),
            const SizedBox(height: 15),
            buildAIHintCard(), 
            const SizedBox(height: 100), 
          ],
        ),
      ),
    );
  }

  Widget buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF5DBB8E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.location_on, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('GreenGIS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFF1FAF5), borderRadius: BorderRadius.circular(20)),
              child: const Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.orange, size: 18),
                  SizedBox(width: 4),
                  Text('1,240 GP', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.notifications_outlined, color: Colors.grey, size: 26),
          ],
        )
      ],
    );
  }

  Widget buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5DBB8E), Color(0xFF2D9F83)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: const Color(0xFF5DBB8E).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ĐIỂM XANH TÍCH LŨY', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('1.250 GP', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          buildStreakBadge(),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF5DBB8E) : Colors.grey[400], size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFF5DBB8E) : Colors.grey[400],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 20),
        SizedBox(width: 5),
        Text('5 ngày streak!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget buildDailyProgress() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Tiến trình hôm nay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B4332))),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(10)),
        child: const Text('60% Hoàn thành', style: TextStyle(fontSize: 12, color: Color(0xFF5DBB8E), fontWeight: FontWeight.bold)),
      ),
    ]);
  }

  Widget buildMissionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: const Row(children: [
        Icon(Icons.menu_book_rounded, color: Color(0xFF7B61FF), size: 30),
        SizedBox(width: 15),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Hoàn thành bài học Nhựa SUP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text('Kiến thức cơ bản', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ])),
        Icon(Icons.check_circle, color: Color(0xFF5DBB8E), size: 28),
      ]),
    );
  }

  Widget buildAIHintCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF1FAF5), borderRadius: BorderRadius.circular(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.smart_toy_outlined, color: Color(0xFF1B4332), size: 24),
        const SizedBox(width: 15),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('MẸO XANH TỪ AI BUDDY', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('"Bạn có biết: Dùng bình nước cá nhân giúp giảm thiểu hàng trăm chai nhựa mỗi năm."', style: TextStyle(color: Color(0xFF1B4332), fontSize: 14)),
        ])),
      ]),
    );
  }
}