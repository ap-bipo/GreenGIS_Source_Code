import 'package:supabase_flutter/supabase_flutter.dart';
import '/Components/Topic.dart';
import '/Components/FlashcardData.dart';

class FlashcardService {
  final _supabase = Supabase.instance.client;

  Future<List<Topic>> fetchTopics() async {
    // 1. Lấy danh sách Topics
    final List<dynamic> topicsData = await _supabase.from('topics').select();

    List<Topic> topics = [];

    for (var t in topicsData) {
      // 2. Lấy NGẪU NHIÊN 3 cards cho mỗi topic thông qua RPC đã tạo ở bước trước
      // Nếu chưa tạo RPC, bạn có thể lấy thường: .from('flashcards').select().eq('topic_id', t['id']).limit(3)
      final List<dynamic> cardsData = await _supabase
          .rpc('get_random_flashcards', params: {'t_id': t['id']});

      List<FlashcardData> cards = cardsData.map((c) => FlashcardData(
        question: c['question'],
        answer: c['answer'],
        examples: c['examples'] ?? "",
      )).toList();

      topics.add(Topic.fromSupabase(t, cards));
    }
    return topics;
  }
}