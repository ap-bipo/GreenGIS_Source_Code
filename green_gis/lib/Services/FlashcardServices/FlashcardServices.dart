import 'package:supabase_flutter/supabase_flutter.dart';
import '/Components/Topic.dart';
import '/Components/FlashcardData.dart';

class FlashcardService {
  final _supabase = Supabase.instance.client;

  Future<List<Topic>> fetchTopics() async {
    final List<dynamic> topicsData = await _supabase.from('topics').select();

    List<Topic> topics = [];

    for (var t in topicsData) {
      final List<dynamic> cardsData = await _supabase.rpc(
        'get_random_flashcards',
        params: {'t_id': t['id']},
      );

      List<FlashcardData> cards = cardsData
          .map(
            (c) => FlashcardData(
              question: c['question'],
              answer: c['answer'],
              examples: c['examples'] ?? "",
            ),
          )
          .toList();

      topics.add(Topic.fromSupabase(t, cards));
    }
    return topics;
  }
}
