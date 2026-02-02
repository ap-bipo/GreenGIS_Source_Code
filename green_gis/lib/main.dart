import 'package:flutter/material.dart';
import 'package:green_gis/Pages/IntroductionPages/UserConfirmationPage.dart';
import 'package:green_gis/Pages/RegisterPage.dart';
import 'package:green_gis/Services/Authentication/LoginUserNavigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Pages/LoginPage.dart';
import 'Pages/IntroductionPages/InformationPage.dart';
import 'Pages/IntroductionPages/TrackingFeatureIntroduction.dart';
import 'Pages/IntroductionPages/LearnAndPlayIntroduction.dart';
import 'Pages/IntroductionPages/LeaderBoardIntroduction.dart';
import 'Pages/IntroductionPages/AIBuddyIntroduction.dart';
import './Pages/HomePage.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://shlkwidkzufpsulwqcyd.supabase.co',
    anonKey: 'sb_publishable_xQ4_lz0yU2h5TWFpB7JkUw_g2auH7yQ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginUserNavigation(),
    );
  }
}
