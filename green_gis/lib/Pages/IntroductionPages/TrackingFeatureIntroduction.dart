import 'package:flutter/material.dart';
import 'package:green_gis/Components/Button.dart';
import 'package:green_gis/Pages/IntroductionPages/LearnAndPlayIntroduction.dart';
import 'package:green_gis/Services/Constants/Constants.dart';

class TrackingFeatureIntroduction extends StatelessWidget {
  const TrackingFeatureIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),  
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Theo dõi nhựa\nhằng ngày",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Constants.darkGreen,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Đo lường lượng nhựa bạn dùng mỗi ngày",
                style: TextStyle(color: Constants.textGrey),
              ),

              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 8,
                          valueColor: AlwaysStoppedAnimation(
                            Constants.lightGreen,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: 0.75, 
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation(
                            Constants.primary,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "75%",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Constants.primary,
                            ),
                          ),
                          Text(
                            "TIẾN ĐỘ",
                            style: TextStyle(color: Constants.textGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  _statCard("TÚI NILON", "12"),
                  const SizedBox(width: 16),
                  _statCard("CHAI NHỰA", "08"),
                ],
              ),
              const Spacer(),
              Button(
                text: "Tiếp theo",
                onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (_) => LearnAndPlayIntroduction()))},
                Size: double.infinity,
                colorBox: Constants.primary,
                colorText: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Constants.lightGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Constants.textGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Constants.darkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
