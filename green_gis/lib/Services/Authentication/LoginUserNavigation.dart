import 'package:flutter/material.dart';
import '../../Pages/LoginPage.dart';
import '../../Pages/RegisterPage.dart';

class LoginUserNavigation extends StatefulWidget {
  const LoginUserNavigation({super.key});

  @override
  State<LoginUserNavigation> createState() => _LoginUserNavigationState();
}

class _LoginUserNavigationState extends State<LoginUserNavigation> {
  bool showLoginPage = true;
  // ignore: non_constant_identifier_names
  void TogglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  
  
  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(onTap: TogglePages);
    } else {
      return RegisterPage(onTap: TogglePages);
    }
  }
}