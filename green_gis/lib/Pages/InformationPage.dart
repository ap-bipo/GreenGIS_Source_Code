import 'package:flutter/material.dart';
import 'package:green_gis/Components/TextFill.dart';
import 'package:green_gis/Services/LoginUserNavigation.dart';
import 'package:green_gis/Components/Button.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
    static const Color primaryGreen = Color(0xFF10B986);
  final TextEditingController userName = TextEditingController();
  final TextEditingController userClass = TextEditingController();
  final TextEditingController userSchool = TextEditingController();

  bool get isFormValid =>
      userName.text.isNotEmpty &&
      userClass.text.isNotEmpty &&
      userSchool.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    userName.addListener(_onChanged);
    userClass.addListener(_onChanged);
    userSchool.addListener(_onChanged);
  }

  void _onChanged() {
    setState(() {}); 
  }

  @override
  void dispose() {
    userName.dispose();
    userClass.dispose();
    userSchool.dispose();
    super.dispose();
  }

  Future<void> validation() async {
    if (!isFormValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 7,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginUserNavigation(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Nhập thông tin',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    'Hãy nhập các thông tin về bạn để chúng mình có thể tổng hợp học sinh',
                    style: TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 35),
                  const Text(
                    'User Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w100),
                  ),

                  const SizedBox(height: 35),
                  TextFill(
                    text: 'Họ và tên',
                    controller: userName,
                    hideText: false,
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 35),
                  TextFill(
                    text: 'Lớp',
                    controller: userClass,
                    hideText: false,
                    icon: Icons.class_,
                  ),

                  const SizedBox(height: 35),
                  TextFill(
                    text: 'Trường',
                    controller: userSchool,
                    hideText: false,
                    icon: Icons.school,
                  ),

                  const SizedBox(height: 40),
      
                  Button(
                    text: "Xong",
                    onTap: isFormValid ? validation : null,
                    colorBox: isFormValid ? Colors.white : Colors.grey,
                    colorText: isFormValid
                        ? Colors.white
                        : primaryGreen,
                    Size: 359,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
