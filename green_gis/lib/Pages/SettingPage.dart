import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:green_gis/Services/Users/ProfileServices.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _profileService = ProfileService();
  
  bool _isLoading = true;
  String? _avatarUrl;
  File? _imageFile;   

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await _profileService.getProfile();
    if (mounted) {
      setState(() {
        _nameController.text = data['full_name'] ?? '';
        _bioController.text = data['bio'] ?? '';
        _avatarUrl = data['avatar_url'];
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // UPLOAD IMAGE AND TEXT
  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      String? newAvatarUrl;
      // CHANGE IN THE SUPABASE
      if (_imageFile != null) {
        newAvatarUrl = await _profileService.uploadAvatar(_imageFile!);
      }
      // SAVE USERS' INFOS
      await _profileService.updateProfile(
        fullName: _nameController.text.trim(),
        bio: _bioController.text.trim(),
        avatarUrl: newAvatarUrl ?? _avatarUrl, 
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật hồ sơ thành công!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chỉnh sửa hồ sơ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: const Text("Lưu", style: TextStyle(color: Color(0xFF00D180), fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: _isLoading && _nameController.text.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // AVATAR
                  Center(
                    child: Stack(
                      children: [
  
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider // Ảnh vừa chọn
                              : (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                                  ? NetworkImage(_avatarUrl!) // Ảnh từ Supabase
                                  : null,
                          child: (_imageFile == null && (_avatarUrl == null || _avatarUrl!.isEmpty))
                              ? const Icon(Icons.person, size: 60, color: Colors.grey)
                              : null,
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00D180),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text("Thay đổi ảnh đại diện", style: TextStyle(color: Color(0xFF00D180))),
                  ),
                  const SizedBox(height: 30),
                  //USERNAME
                  _buildTextField(
                    label: "Tên hiển thị",
                    controller: _nameController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  // USER'S BIO
                  _buildTextField(
                    label: "Tiểu sử (Bio)",
                    controller: _bioController,
                    icon: Icons.info_outline,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
    );
  }

  // Widget Helper để vẽ TextField đẹp
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: "Nhập $label...",
            filled: true,
            fillColor: const Color(0xFFF8F9FD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF00D180), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}