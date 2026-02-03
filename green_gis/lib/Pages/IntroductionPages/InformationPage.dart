import 'package:flutter/material.dart';
import 'package:green_gis/Components/TextFill.dart';
import 'package:green_gis/Pages/IntroductionPages/UserConfirmationPage.dart';
import 'package:green_gis/Components/Button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:green_gis/Components/FieldLabel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  static const Color primaryGreen = Color(0xFF5DBB8E);
  final TextEditingController userName = TextEditingController();
  final TextEditingController userClass = TextEditingController();
  final TextEditingController userSchool = TextEditingController();

  bool _isLoading = false;

  bool get isFormValid =>
      userName.text.trim().isNotEmpty &&
      userClass.text.trim().isNotEmpty &&
      userSchool.text.trim().isNotEmpty;

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

  // UPDATE ON SUPABASE ONBOARDING STATUS
  Future<void> validation() async {
    if (!isFormValid) return;

    setState(() => _isLoading = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;
      
      if (user != null) {
        await Supabase.instance.client.from('profiles').update({
          'full_name': userName.text.trim(),
          'class_name': userClass.text.trim(),
          'school_name': userSchool.text.trim(),
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('id', user.id);
        if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => UserConfirmationPage()));
          print("Finish personal information");
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView( 
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: SvgPicture.asset(
                  'assets/AppLogo.svg',
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),

              const Text(
                'Nhập thông tin',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                'Hãy nhập các thông tin về bạn để chúng mình có thể tổng hợp học sinh',
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 40),
              FieldLabel(
                label: "Full Name",
                spaceVal: 8.0,  
              ),
              TextFill(
                text: '',
                controller: userName,
                hideText: false,
                icon: Icons.mail_outline, 
              ),
              const SizedBox(height: 25),
              FieldLabel(
                label: 'Class', 
                spaceVal: 8.0,
              ),
              TextFill(
                text: '',
                controller: userClass,
                hideText: false,
                icon: Icons.phone_outlined, 
              ),
              const SizedBox(height: 25),
              FieldLabel(
                label: 'School',
                spaceVal: 8.0,
              ),
              TextFill(
                text: '',
                controller: userSchool,
                hideText: false,
                icon: Icons.mail_outline, 
              ),
              const SizedBox(height: 50),
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: primaryGreen))
              else
                Button(
                  text: "Xong",
                  onTap: isFormValid ? validation : null,
                  colorBox: isFormValid ? primaryGreen : const Color(0xFFE0E0E0),
                  colorText: isFormValid ? Colors.white : Colors.grey,
                  Size: double.infinity,
                ),
            ],
          ),
        ),
      ),
    );
  }
  
}