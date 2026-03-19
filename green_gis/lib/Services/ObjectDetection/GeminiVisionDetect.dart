import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAnalysisResult {
  final bool isValid;
  final List<String> targetItems;
  final List<String> allDetectedItems;
  final String commentary;
  final int quantity;

  const GeminiAnalysisResult({
    required this.isValid,
    required this.targetItems,
    required this.allDetectedItems,
    required this.commentary,
    required this.quantity,
  });

  static GeminiAnalysisResult empty() => const GeminiAnalysisResult(
    isValid: false,
    targetItems: [],
    allDetectedItems: [],
    commentary: 'Chưa có dữ liệu phân tích. Hãy chụp một bức ảnh.',
    quantity: 0,
  );
}

class GeminiVisionDetectService {
  static const String _apiKey = 'your_gemini_api_key';

  static const List<String> _targetKeywords = [
    'chai nhựa',
    'chai',
    'bottle',
    'plastic bottle',
    'túi nilon',
    'túi nhựa',
    'plastic bag',
    'nylon bag',
    'cốc nhựa',
    'ly nhựa',
    'plastic cup',
    'ống hút',
    'straw',
    'thùng rác',
    'garbage bin',
    'trash can',
    'trash bin',
    'hộp nhựa',
    'plastic container',
    'rác thải nhựa',
    'plastic waste',
    'can',
    'lon',
  ];

  late final GenerativeModel _model;

  GeminiVisionDetectService() {
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: _apiKey);
  }

  Future<GeminiAnalysisResult> analyzeImage(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();

      final prompt = '''
Phân tích bức ảnh này và trả lời theo định dạng JSON sau (KHÔNG thêm markdown, KHÔNG thêm ```json):

{
  "detected_objects": ["danh sách tất cả vật thể trong ảnh"],
  "plastic_waste_items": ["danh sách vật thể liên quan đến nhựa/rác thải trong ảnh, để trống nếu không có"],
  "quantity": <số lượng vật thể nhựa/rác tìm thấy, 0 nếu không có>,
  "is_valid": <true nếu có bất kỳ vật thể nhựa/rác nào, false nếu không>,
  "commentary": "<nhận xét ngắn gọn bằng tiếng Việt, thân thiện, khoảng 1-2 câu về những gì thấy trong ảnh và hành động xanh nếu hợp lệ>"
}

Các vật thể hợp lệ bao gồm: chai nhựa, túi nilon, cốc nhựa, ống hút, thùng rác, hộp nhựa, lon, rác thải nhựa, bao bì nhựa.
''';

      final response = await _model.generateContent([
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ]);

      final text = response.text ?? '';
      return _parseResponse(text);
    } catch (e) {
      return GeminiAnalysisResult(
        isValid: false,
        targetItems: [],
        allDetectedItems: [],
        commentary: 'Lỗi phân tích ảnh: $e',
        quantity: 0,
      );
    }
  }

  GeminiAnalysisResult _parseResponse(String raw) {
    try {
      String cleaned = raw.trim();
      if (cleaned.startsWith('```')) {
        cleaned = cleaned.replaceAll(RegExp(r'```json|```'), '').trim();
      }
      final detected = _extractStringList(cleaned, 'detected_objects');
      final plasticItems = _extractStringList(cleaned, 'plastic_waste_items');
      final quantity = _extractInt(cleaned, 'quantity');
      final isValid = _extractBool(cleaned, 'is_valid');
      final commentary = _extractString(cleaned, 'commentary');

      return GeminiAnalysisResult(
        isValid: isValid || plasticItems.isNotEmpty,
        targetItems: plasticItems,
        allDetectedItems: detected,
        commentary: commentary.isNotEmpty
            ? commentary
            : (plasticItems.isNotEmpty
                  ? 'AI đã phát hiện ${plasticItems.join(', ')}. Hành động xanh được xác nhận! 🌿'
                  : 'Không tìm thấy rác thải nhựa trong ảnh. Hãy thử chụp rõ hơn.'),
        quantity: quantity > 0 ? quantity : plasticItems.length,
      );
    } catch (e) {
      return GeminiAnalysisResult(
        isValid: false,
        targetItems: [],
        allDetectedItems: [],
        commentary: 'Không thể đọc kết quả từ AI. Vui lòng thử lại.',
        quantity: 0,
      );
    }
  }

  List<String> _extractStringList(String json, String key) {
    final regex = RegExp('"$key"\\s*:\\s*\\[([^\\]]*)\\]', dotAll: true);
    final match = regex.firstMatch(json);
    if (match == null) return [];
    final content = match.group(1) ?? '';
    return RegExp(
      r'"([^"]+)"',
    ).allMatches(content).map((m) => m.group(1)!).toList();
  }

  int _extractInt(String json, String key) {
    final regex = RegExp('"$key"\\s*:\\s*(\\d+)');
    final match = regex.firstMatch(json);
    return int.tryParse(match?.group(1) ?? '0') ?? 0;
  }

  bool _extractBool(String json, String key) {
    final regex = RegExp('"$key"\\s*:\\s*(true|false)');
    final match = regex.firstMatch(json);
    return match?.group(1) == 'true';
  }

  String _extractString(String json, String key) {
    final regex = RegExp(
      '"$key"\\s*:\\s*"((?:[^"\\\\]|\\\\.)*)"',
      dotAll: true,
    );
    final match = regex.firstMatch(json);
    return match?.group(1)?.replaceAll('\\"', '"') ?? '';
  }
}
