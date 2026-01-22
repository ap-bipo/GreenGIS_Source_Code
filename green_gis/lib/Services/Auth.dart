import 'package:supabase_flutter/supabase_flutter.dart'; 

class Auth{
  
  final supabase = Supabase.instance.client;

  Future<void> signUp(String email, String password) async {
    await supabase.auth.signUp(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

}