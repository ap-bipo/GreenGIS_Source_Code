class FlashcardData {
  final String question;
  final String answer;
  final String examples;

  FlashcardData({
    required this.question,
    required this.answer,
    required this.examples,
  });
  //CONVERT FROM SUPABASE
  factory FlashcardData.fromMap(Map<String, dynamic> map) {
    return FlashcardData(
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      examples: map['examples'] ?? '',
    );
  }
}