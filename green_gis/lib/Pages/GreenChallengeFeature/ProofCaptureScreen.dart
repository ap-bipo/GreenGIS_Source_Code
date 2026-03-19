import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:green_gis/Services/ObjectDetection/GroqVisionDetect.dart';
import 'package:green_gis/Services/Users/Users.dart';
import 'package:green_gis/Pages/GreenChallengeFeature/Widgets/ProofCameraPreview.dart';
import 'package:green_gis/Pages/GreenChallengeFeature/Widgets/ProofAIResultCard.dart';
import 'package:green_gis/Pages/GreenChallengeFeature/Widgets/ProofActionNote.dart';

class ProofCaptureScreen extends StatefulWidget {
  const ProofCaptureScreen({super.key});

  @override
  State<ProofCaptureScreen> createState() => _ProofCaptureScreenState();
}

class _ProofCaptureScreenState extends State<ProofCaptureScreen> {
  final picker = ImagePicker();
  final GroqVisionDetectService ai = GroqVisionDetectService();
  final Users userServices = Users();

  File? image;
  int quantity = 0;
  String resultText = "";
  String detailedAnalysis =
      "⚠️ LƯU Ý: Bạn bắt buộc phải chụp ảnh rác thải CÙNG VỚI THÙNG RÁC (hành động vứt rác) để được hệ thống xác nhận và cộng điểm GP nhé!";
  bool isDetecting = false;
  bool canClaimPoints = false;
  List<String> targetItems = [];
  List<String> allDetectedItems = [];
  List<Map<String, dynamic>> get detectedItemsDetails {
    return allDetectedItems
        .map(
          (item) => {
            'label': item,
            'isTarget': targetItems.any(
              (t) => item.toLowerCase().contains(t.toLowerCase()),
            ),
          },
        )
        .toList();
  }

  final List<String> targetLabels = [
    'chai',
    'bottle',
    'tuúi',
    'thùng',
    'trash',
    'garbage',
    'plastic',
    'nhựa',
    'can',
    'lon',
    'straw',
    'ống hút',
  ];

  Future<void> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() {
      image = File(picked.path);
      isDetecting = true;
      resultText = "Groq AI (Llama 3.2 Vision) đang phân tích ảnh...";
      canClaimPoints = false;
      targetItems = [];
      allDetectedItems = [];
    });

    final result = await ai.analyzeImage(image!);

    setState(() {
      isDetecting = false;
      targetItems = result.targetItems;
      allDetectedItems = result.allDetectedItems;
      quantity = result.quantity > 0
          ? result.quantity
          : (result.isValid ? 1 : 0);
      canClaimPoints = result.isValid;
      resultText = result.isValid
          ? "Đã nhận diện: Rác thải nhựa!"
          : "Không tìm thấy vật liệu hợp lệ.";
      detailedAnalysis = result.commentary;
    });
  }

  Future<void> _claimGreenPoints() async {
    if (!canClaimPoints) return;
    int pointsEarned = quantity * 10;
    await Future.delayed(const Duration(seconds: 1));
    bool success = await userServices.addPoints(pointsEarned);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Chúc mừng! Bạn đã nhận $pointsEarned GP.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi xảy ra khi cộng điểm.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 20),
              ProofCameraPreview(
                image: image,
                isDetecting: isDetecting,
                resultText: resultText,
                onPickImage: pickImage,
              ),
              const SizedBox(height: 20),
              ProofAIResultCard(
                hasAnalysis: detectedItemsDetails.isNotEmpty,
                waiting: image == null,
                canClaimPoints: canClaimPoints,
                detectedItemsDetails: detectedItemsDetails,
                detailedAnalysis: detailedAnalysis,
                quantity: quantity,
              ),
              const SizedBox(height: 20),
              ProofActionNote(detailedAnalysis: detailedAnalysis),
              const SizedBox(height: 30),
              _buildContinueButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Color(0xFF1B4332),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Minh chứng SUP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: const Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 24,
                  color: Color(0xFF1B4332),
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canClaimPoints ? _claimGreenPoints : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canClaimPoints
              ? const Color(0xFF22B07D)
              : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 5,
          shadowColor: const Color(0xFF22B07D).withOpacity(0.5),
        ),
        child: Text(
          canClaimPoints ? 'Nhận Green Points' : 'Chưa đủ điều kiện',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
