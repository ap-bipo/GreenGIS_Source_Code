import 'package:flutter/material.dart';
import 'package:green_gis/Services/Authentication/LoginUserNavigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'your_supabase_url',
    anonKey: 'your_supabase_anon_key',
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
