import 'package:green_gis/Components/Button.dart';
import 'package:green_gis/Components/TextFill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_gis/Pages/IntroductionPages/InformationPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:green_gis/Services/Authentication/Auth.dart';
import 'package:green_gis/Services/Users/Users.dart';
import './HomePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Users user = Users();
  final Auth auth = Auth();
  final TextEditingController confirmPasswordTextController = TextEditingController(); 
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  static const Color primaryGreen = Color(0xFF10B986);

  void displayMessages(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }
  void signUpUser() async {
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    if (passwordTextController.text != confirmPasswordTextController.text) {
      Navigator.pop(context);
      displayMessages("Passwords do not match");
      return;
    }
    try {
      await auth.signUp(
        emailTextController.text,
        passwordTextController.text,
      );
      if (context.mounted) {
        if(await user.getOnBoardingStatus()){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => InformationPage()),
          );
        }
      }
    } on AuthException catch (e) {
      if (context.mounted) Navigator.pop(context);
      displayMessages(e.message);
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
      displayMessages("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreen,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGreen,
        leadingWidth: 170,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            'assets/AppLogo.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Center(
        child: Transform.translate(
          offset: const Offset(0, -40),
          child: Container(
            width: 360,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Chào mừng bạn',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                TextFill(
                  text: 'Email',
                  controller: emailTextController,
                  hideText: false,
                  icon: Icons.email,
                ),

                const SizedBox(height: 16),

                TextFill(
                  text: 'Password',
                  controller: passwordTextController,
                  hideText: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 12),

                TextFill(
                  text: 'Confirm Password',
                  controller: confirmPasswordTextController,
                  hideText: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Quên mật khẩu ?',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Button(
                  text: 'Đăng nhập',
                  Size: 220,
                  onTap: () {
                    signUpUser();
                  },
                  colorBox: Colors.grey,
                  colorText: const Color.fromARGB(255, 255, 254, 254),
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                        label: const Text('Google'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        label: const Text('Facebook'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                 const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Đã có tài khoản rồi ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 85, 83, 63),
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        ' Đăng nhập',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 33, 94, 144),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}