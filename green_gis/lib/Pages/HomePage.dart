import 'package:flutter/material.dart';
import 'package:green_gis/Services/Constants/Constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Constants.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.primary.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Icon(Icons.location_on, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'GreenGIS',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1FAF5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.monetization_on, color: Constants.accentYellow, size: 18),
                            SizedBox(width: 4),
                            Text(
                              '1,240 GP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Constants.darkGreen,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Icon(Icons.notifications_outlined, color: Colors.grey[600], size: 22),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                'Chào Minh Anh 👋',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Constants.darkGreen),
              ),
              const SizedBox(height: 8),
              Text(
                'Cùng gieo mầm xanh cho lớp mình nhé!',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),

              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5DBB8E), Color(0xFF2D9F83)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ĐIỂM XANH TÍCH LŨY',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '1.250 GP',
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2), 
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.withOpacity(0.5)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 20),
                          SizedBox(width: 5),
                          Text(
                            '5 ngày streak!',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiến trình hôm nay',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Constants.darkGreen),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2F1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '60% Hoàn thành',
                      style: TextStyle(fontSize: 12, color: Constants.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: Color(0xFF7B61FF)),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hoàn thành bài học', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Nhựa SUP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Kiến thức cơ bản', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Constants.primary, size: 28),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1FAF5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.smart_toy_outlined, color: Constants.darkGreen, size: 24),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MẸO XANH TỪ AI BUDDY', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          SizedBox(height: 4),
                          Text(
                            '"Bạn có biết: Thay vì lấy túi nilon cho 1 ổ bánh mì, bạn có thể cầm tay để giảm 100 năm phân hủy..."',
                            style: TextStyle(color: Constants.darkGreen, fontSize: 14, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
              
              const SizedBox(height: 80), 
            ],
          ),
        ),
      ),
      
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {},
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
            child: const Icon(Icons.add_circle, color: Constants.primary, size: 55),
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
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_filled, "Home", 0),
              _buildNavItem(Icons.videogame_asset_outlined, "Học & Chơi", 1),
              const SizedBox(width: 40), // Khoảng trống cho nút FAB ở giữa
              _buildNavItem(Icons.smart_toy_outlined, "AI Buddy", 2),
              _buildNavItem(Icons.bar_chart_rounded, "Thống kê", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            color: isSelected ? const Color(0xFF5DBB8E) : Colors.grey[400],
            size: 26,
          ),
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
    );
  }
}