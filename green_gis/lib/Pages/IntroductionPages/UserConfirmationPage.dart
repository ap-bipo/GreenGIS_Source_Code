import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_gis/Components/Button.dart';
import 'package:green_gis/Pages/IntroductionPages/TrackingFeatureIntroduction.dart';
import 'package:green_gis/Services/Authentication/LoginUserNavigation.dart';
import 'package:green_gis/Services/Constants/Constants.dart';
import 'TrackingFeatureIntroduction.dart';
import 'package:green_gis/Services/Authentication/Auth.dart';

class UserConfirmationPage extends StatelessWidget {
  UserConfirmationPage({super.key});
  final Auth auth = Auth();

  Future<void> previousPage(BuildContext context) async {
    auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginUserNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 200,
        leading: Row(
          children: [
            const SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              onPressed: () => previousPage(context),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: SvgPicture.asset(
                'assets/AppLogo.svg',
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),

              SvgPicture.asset('Completed_Icon.svg', height: 220),
              const SizedBox(height: 40),

              const Text(
                'CHÚC MỪNG',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF1B4332)),
              ),
              const SizedBox(height: 15),

              const Text(
                'Chúc mừng bạn. Tài khoản của bạn đã được xác minh!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.blueGrey, height: 1.5),
              ),
              const Spacer(flex: 3),

              Button(
                text: 'Tiếp tục',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TrackingFeatureIntroduction())),
                Size: double.infinity,
                colorBox: const Color(0xFF5DBB8E),
                colorText: Colors.white,
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}