import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HFDetectionResult {
  final bool isValid;
  final List<String> targetItems;
  final List<DetectedObject> allDetectedObjects;
  final String commentary;
  final int quantity;

  const HFDetectionResult({
    required this.isValid,
    required this.targetItems,
    required this.allDetectedObjects,
    required this.commentary,
    required this.quantity,
  });

  static HFDetectionResult empty() => const HFDetectionResult(
    isValid: false,
    targetItems: [],
    allDetectedObjects: [],
    commentary: 'Chưa có dữ liệu phân tích. Hãy chụp một bức ảnh.',
    quantity: 0,
  );
}

class DetectedObject {
  final String label;
  final double score;
  final bool isTarget;

  const DetectedObject({
    required this.label,
    required this.score,
    required this.isTarget,
  });
}

class HuggingFaceDetectService {
  static const String _hfToken = 'hugging_face_token';
  static const String _modelUrl = 'model_url';
  static const List<String> _targetLabels = [
    'bottle',
    'cup',
    'wine glass',
    'trash can',
    'garbage bin',
    'plastic bag',
    'can',
    'vase',
    'bowl',
  ];

  Future<HFDetectionResult> analyzeImage(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();

      final response = await http
          .post(
            Uri.parse(_modelUrl),
            headers: {
              'Authorization': 'Bearer $_hfToken',
              'Content-Type': 'application/octet-stream',
            },
            body: imageBytes,
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return _parseResponse(response.body);
      } else if (response.statusCode == 503) {
        // Model is still loading (cold start) — HF loads models on demand
        return HFDetectionResult(
          isValid: false,
          targetItems: [],
          allDetectedObjects: [],
          commentary:
              'Model AI đang khởi động (cold start). Vui lòng thử lại sau 20-30 giây.',
          quantity: 0,
        );
      } else if (response.statusCode == 410) {
        return HFDetectionResult(
          isValid: false,
          targetItems: [],
          allDetectedObjects: [],
          commentary:
              'Model không còn khả dụng trên HF free tier. Vui lòng thông báo cho dev.',
          quantity: 0,
        );
      } else {
        return HFDetectionResult(
          isValid: false,
          targetItems: [],
          allDetectedObjects: [],
          commentary: 'Lỗi API (${response.statusCode}): ${response.body}',
          quantity: 0,
        );
      }
    } catch (e) {
      return HFDetectionResult(
        isValid: false,
        targetItems: [],
        allDetectedObjects: [],
        commentary: 'Không thể kết nối đến Hugging Face API: $e',
        quantity: 0,
      );
    }
  }

  HFDetectionResult _parseResponse(String body) {
    final List<dynamic> raw = jsonDecode(body) as List<dynamic>;

    final List<DetectedObject> objects = raw.map((item) {
      final label = (item['label'] as String).toLowerCase();
      final score = (item['score'] as num).toDouble();
      final isTarget = _targetLabels.any((t) => label.contains(t));
      return DetectedObject(label: label, score: score, isTarget: isTarget);
    }).toList();
    final confident = objects.where((o) => o.score >= 0.5).toList();
    final targetFound = confident.where((o) => o.isTarget).toList();

    final List<String> targetLabelsFound = targetFound
        .map((o) => o.label)
        .toSet()
        .toList();

    String commentary;
    if (targetFound.isNotEmpty) {
      final itemText = targetLabelsFound.join(', ');
      commentary =
          '🌿 AI phát hiện ${targetFound.length} vật thể rác thải nhựa: $itemText. '
          'Hành động xanh được xác nhận! Bạn sẽ nhận được ${targetFound.length * 10} Green Points.';
    } else if (confident.isNotEmpty) {
      final allNames = confident.map((o) => o.label).join(', ');
      commentary =
          'AI nhận thấy: $allNames. Tuy nhiên không tìm thấy rác thải nhựa hay thùng rác. '
          'Hãy thử chụp rõ hơn hoặc đặt vật thể vào giữa khung hình.';
    } else {
      commentary =
          'AI không nhận diện được vật thể nào rõ ràng trong ảnh. '
          'Hãy đảm bảo ánh sáng đủ và vật thể không bị che khuất.';
    }

    return HFDetectionResult(
      isValid: targetFound.isNotEmpty,
      targetItems: targetLabelsFound,
      allDetectedObjects: confident,
      commentary: commentary,
      quantity: targetFound.length,
    );
  }
}
