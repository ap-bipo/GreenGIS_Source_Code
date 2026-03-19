import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GroqDetectionResult {
  final bool isValid;
  final List<String> targetItems;
  final List<String> allDetectedItems;
  final String commentary;
  final int quantity;

  const GroqDetectionResult({
    required this.isValid,
    required this.targetItems,
    required this.allDetectedItems,
    required this.commentary,
    required this.quantity,
  });

  static GroqDetectionResult empty() => const GroqDetectionResult(
    isValid: false,
    targetItems: [],
    allDetectedItems: [],
    commentary: 'Chưa có dữ liệu phân tích. Hãy chụp một bức ảnh.',
    quantity: 0,
  );
}

class GroqVisionDetectService {
  static const String _groqApiKey = 'groq_api_key';

  static const String _apiUrl = 'groq_api_url';

  static const String _model = 'api_meta';

  static const List<String> _targetKeywords = [
    'chai nhựa',
    'chai',
    'bottle',
    'plastic bottle',
    'túi nilon',
    'túi nhựa',
    'plastic bag',
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

  Future<GroqDetectionResult> analyzeImage(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final prompt = '''
Phân tích bức ảnh này để phân loại rác thải và trả lời theo định dạng JSON sau (KHÔNG thêm markdown, KHÔNG thêm ```):

{"detected_objects":["danh sách các vật thể CHÍNH trong ảnh bằng tiếng Việt"],"plastic_waste_items":["danh sách vật thể rác thải/nhựa hợp lệ trong ảnh, để trống nếu không có"],"quantity":<số lượng rác thải>,"is_valid":<true hoặc false>,"commentary":"<nhận xét 1-2 câu tiếng Việt>"}

LƯU Ý QUAN TRỌNG ĐỂ HỢP LỆ (is_valid = true):
1. BỨC ẢNH BẮT BUỘC PHẢI CÓ "THÙNG RÁC" (người dùng đang vứt rác vào thùng). NẾU KHÔNG CÓ THÙNG RÁC TRONG ẢNH, BẮT BUỘC trả về "is_valid": false vì chưa hoàn thành hành động bỏ rác đúng nơi quy định.
2. NẾU ảnh chứa các vật thể chính KHÔNG phải rác (ví dụ: màn hình máy tính, điện thoại, người, phong cảnh chung chung), BẮT BUỘC trả về "is_valid": false.
3. Nếu "is_valid": false, commentary hãy giải thích nhẹ nhàng lý do không cộng điểm (ví dụ: "Thiếu thùng rác" hoặc "Có chứa vật thể không liên quan").''';

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              'Authorization': 'Bearer $_groqApiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': _model,
              'messages': [
                {
                  'role': 'user',
                  'content': [
                    {
                      'type': 'image_url',
                      'image_url': {
                        'url': 'data:image/jpeg;base64,$base64Image',
                      },
                    },
                    {'type': 'text', 'text': prompt},
                  ],
                },
              ],
              'max_tokens': 512,
              'temperature': 0.1,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content =
            data['choices'][0]['message']['content'] as String? ?? '';
        return _parseResponse(content);
      } else {
        final err = jsonDecode(response.body);
        final errMsg = err['error']?['message'] ?? response.body;
        return GroqDetectionResult(
          isValid: false,
          targetItems: [],
          allDetectedItems: [],
          commentary: 'Lỗi Groq API (${response.statusCode}): $errMsg',
          quantity: 0,
        );
      }
    } catch (e) {
      return GroqDetectionResult(
        isValid: false,
        targetItems: [],
        allDetectedItems: [],
        commentary: 'Không thể kết nối Groq API: $e',
        quantity: 0,
      );
    }
  }

  GroqDetectionResult _parseResponse(String raw) {
    try {
      String cleaned = raw.trim();
      // Strip markdown fences if present
      cleaned = cleaned
          .replaceAll(RegExp(r'```json', caseSensitive: false), '')
          .replaceAll('```', '')
          .trim();

      // Find first { and last } to extract JSON
      final start = cleaned.indexOf('{');
      final end = cleaned.lastIndexOf('}');
      if (start == -1 || end == -1) throw Exception('No JSON found');
      cleaned = cleaned.substring(start, end + 1);

      final json = jsonDecode(cleaned) as Map<String, dynamic>;

      final detected =
          (json['detected_objects'] as List?)?.cast<String>() ?? [];
      final plastic =
          (json['plastic_waste_items'] as List?)?.cast<String>() ?? [];
      final quantity = (json['quantity'] as num?)?.toInt() ?? 0;
      final isValid = json['is_valid'] as bool? ?? plastic.isNotEmpty;
      final commentary = json['commentary'] as String? ?? '';

      // Cross-check plastic items against known keywords
      final targetFound = plastic.isNotEmpty
          ? plastic
          : detected.where((item) {
              final lower = item.toLowerCase();
              return _targetKeywords.any((kw) => lower.contains(kw));
            }).toList();

      final validResult = isValid && targetFound.isNotEmpty;

      return GroqDetectionResult(
        isValid: validResult,
        targetItems: targetFound,
        allDetectedItems: detected,
        commentary: commentary.isNotEmpty
            ? commentary
            : (validResult
                  ? '🌿 AI phát hiện ${targetFound.join(', ')}. Hành động xanh được xác nhận!'
                  : 'Không tìm thấy rác thải nhựa trong ảnh. Hãy chụp rõ vật thể hơn.'),
        quantity: quantity > 0
            ? quantity
            : (validResult ? targetFound.length : 0),
      );
    } catch (_) {
      // Fallback: try keyword matching on raw text
      final lower = raw.toLowerCase();
      final found = _targetKeywords.where((kw) => lower.contains(kw)).toList();
      final valid = found.isNotEmpty;
      return GroqDetectionResult(
        isValid: valid,
        targetItems: found,
        allDetectedItems: [],
        commentary: valid
            ? '🌿 AI phát hiện vật thể liên quan: ${found.join(', ')}.'
            : 'Không tìm thấy rác thải nhựa. Vui lòng thử lại với ảnh rõ hơn.',
        quantity: valid ? found.length : 0,
      );
    }
  }
}
