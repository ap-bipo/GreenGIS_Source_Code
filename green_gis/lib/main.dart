import 'package:flutter/material.dart';
import 'package:green_gis/Pages/RegisterPage.dart';
import 'package:green_gis/Services/LoginUserNavigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Pages/LoginPage.dart';
import 'Pages/InformationPage.dart';



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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InformationPage(),
    );
  }
}
