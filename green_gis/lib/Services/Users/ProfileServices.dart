import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final _supabase = Supabase.instance.client;
  User? get currentUser => _supabase.auth.currentUser;
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final userId = currentUser!.id;
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return data;
    } catch (e) {
      return {};
    }
  }

  Future<String?> uploadAvatar(File imageFile) async {
    try {
      final userId = currentUser!.id;
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      await _supabase.storage
          .from('avatars')
          .upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );
      final imageUrl = _supabase.storage.from('avatars').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      print("Lỗi upload ảnh: $e");
      return null;
    }
  }

  // UPDATE PROFILE
  Future<void> updateProfile({
    required String fullName,
    required String bio,
    String? avatarUrl,
  }) async {
    final userId = currentUser!.id;
    final updates = {
      'id': userId,
      'full_name': fullName,
      'bio': bio,
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (avatarUrl != null) {
      updates['avatar_url'] = avatarUrl;
    }

    await _supabase.from('profiles').upsert(updates);
  }
}
