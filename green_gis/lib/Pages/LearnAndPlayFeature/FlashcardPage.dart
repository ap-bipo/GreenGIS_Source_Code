import 'package:flutter/material.dart';
import 'package:green_gis/Components/FlashcardData.dart';
import 'package:green_gis/Pages/LearnAndPlayFeature/FlashcardSuccessPage.dart';
import 'package:green_gis/Components/Topic.dart';

class FlashcardPage extends StatefulWidget {
  final Topic topic;
  const FlashcardPage({super.key, required this.topic});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  late List<FlashcardData> _flashcards;

  @override
  void initState() {
    super.initState();
    _flashcards = widget.topic.cards;
  }

  int _currentIndex = 0;
  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _flashcards.length - 1) {
        _currentIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FlashcardSuccessPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Flashcard (${_currentIndex + 1}/${_flashcards.length})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Spacer(flex: 1),
            FlashcardContent(
              key: ValueKey(_currentIndex),
              data: _flashcards[_currentIndex],
            ),
            const Spacer(flex: 2),
            ActionButton(
              label: _currentIndex < _flashcards.length - 1
                  ? "Tiếp theo"
                  : "Hoàn thành",
              onPressed: _nextQuestion,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class FlashcardContent extends StatefulWidget {
  final FlashcardData data;
  const FlashcardContent({super.key, required this.data});

  @override
  State<FlashcardContent> createState() => _FlashcardContentState();
}

class _FlashcardContentState extends State<FlashcardContent> {
  bool isFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isFront = !isFront),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isFront ? const Color(0xFFF1FFF8) : const Color(0xFF42C193),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: const Color(0xFFE0F2F1)),
          ),
          child: isFront ? _buildFront() : _buildBack(),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.layers, size: 50, color: Color(0xFF42C193)),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.data.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 40),
        const Text(
          "Chạm để lật mặt",
          style: TextStyle(color: Color(0xFF9E9E9E)),
        ),
      ],
    );
  }

  Widget _buildBack() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.data.answer,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  "VÍ DỤ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.data.examples,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const ActionButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF121826),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}