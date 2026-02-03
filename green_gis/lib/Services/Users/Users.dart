import 'package:supabase_flutter/supabase_flutter.dart';

class Users {
  final _supabase = Supabase.instance.client;
  // GET ALL USER INFO
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      return data;
    } catch (e) {
      print('can not get profiles $e');
      return null;
    }
  }
  // GET FULLNAME
  Future<String> getFullName() async {
    final profile = await getCurrentUserProfile();
    return profile?['full_name'] ?? 'None';
  }
  // GET GREEN_POINTS
   Future<int> getGreenPoints() async {
    final profile = await getCurrentUserProfile();
    return profile?['green_points'] ?? 'None';
  }
  // GET ONBOARDING STATUS
  Future<bool> getOnBoardingStatus() async {
    final profile = await getCurrentUserProfile();
    return profile?['has_seen_onboarding'] ?? false;
  }
  // GET USERS' CLASS AND SCHOOL
  Future<Map<String, String>> getUserEducation() async {
    final profile = await getCurrentUserProfile();
    return {
      'class': profile?['class_name'] ?? 'None',
      'school': profile?['school_name'] ?? 'None',
    };
  }
  // UPDATE ONBOARDING STATUS
  Future<void> updateOnBoardingStatus() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        await _supabase.from('profiles').update({
          'has_seen_onboarding': true,
        }).eq('id', user.id);
      }
    } catch (e) {
      print('can not update $e');
    }
  }

}