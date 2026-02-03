class FlashcardData {
  final String question;
  final String answer;
  final String examples;

  FlashcardData({
    required this.question,
    required this.answer,
    required this.examples,
  });

  // Thêm hàm này để chuyển đổi từ dữ liệu Supabase sang Object
  factory FlashcardData.fromMap(Map<String, dynamic> map) {
    return FlashcardData(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      examples: map['examples'] ?? '',
    );
  }
}