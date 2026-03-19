import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:green_gis/Components/TextFill.dart';
import 'package:green_gis/Pages/HomePage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:green_gis/Services/Constants/Constants.dart';
import 'package:green_gis/Components/Messages.dart';

class AIBuddyPage extends StatefulWidget {
  const AIBuddyPage({super.key});

  @override
  State<AIBuddyPage> createState() => _AIBuddyPageState();
}

class _AIBuddyPageState extends State<AIBuddyPage> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite', // MODEL NAY TU API NHE - AP
      apiKey: 'your_gemini_api_key',
      systemInstruction: Content.system(
        "Bạn là trợ lý GreenGIS chuyên biệt về lối sống bền vững. Trả lời thân thiện, sử dụng emoji, ưu tiên tiếng Việt.",
      ),
    );
    _chatSession = _model.startChat();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;
      final data = await supabase
          .from('chat_messages')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: true);
      if (data.isNotEmpty) {
        List<Map<String, dynamic>> loadedMessages =
            List<Map<String, dynamic>>.from(data);
        List<Content> history = loadedMessages
            .map(
              (m) => m['is_user']
                  ? Content.text(m['content'])
                  : Content.model([TextPart(m['content'])]),
            )
            .toList();
        setState(() {
          _messages = loadedMessages;
          _chatSession = _model.startChat(history: history);
        });
      }
      _scrollToBottom();
    } catch (e) {
      debugPrint("Lỗi load: $e");
    }
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    final userId = supabase.auth.currentUser?.id;
    setState(() {
      _messages.add({'content': text, 'is_user': true});
      _isLoading = true;
      _textController.clear();
    });
    _scrollToBottom();
    try {
      await supabase.from('chat_messages').insert({
        'user_id': userId,
        'content': text,
        'is_user': true,
      });
      final response = await _chatSession.sendMessage(Content.text(text));
      final aiText = response.text ?? "...";
      await supabase.from('chat_messages').insert({
        'user_id': userId,
        'content': aiText,
        'is_user': false,
      });
      setState(() {
        _messages.add({'content': aiText, 'is_user': false});
      });
    } catch (e) {
      debugPrint("Lỗi: $e");
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients)
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_greengis.png',
              height: 24,
              errorBuilder: (c, e, s) =>
                  const Icon(Icons.eco, color: Constants.primary),
            ), // Logo mini
            const SizedBox(width: 8),
            const Text(
              "AI BUDDY",
              style: TextStyle(
                color: Color(0xFF1D212D),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFFFF6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF00D180),
                  radius: 4,
                ),
                const SizedBox(width: 6),
                const Text(
                  "AI ONLINE",
                  style: TextStyle(
                    color: Color(0xFF00D180),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final m = _messages[index];
                      return Messages(
                        text: m['content'],
                        isUser: m['is_user'] == true,
                      );
                    },
                  ),
          ),
          if (_isLoading)
            const LinearProgressIndicator(
              color: Constants.primary,
              backgroundColor: Colors.transparent,
            ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFEFFFF6),
            child: Icon(Icons.face, size: 50, color: Color(0xFF00D180)),
          ),
          const SizedBox(height: 20),
          const Text(
            "Chào bạn, AI Buddy đây!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D212D),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text(
              "Hôm nay bạn sử dụng bao nhiêu nhựa dùng một lần?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['😍', '🙂', '😐', '🙁', '😫']
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(e, style: const TextStyle(fontSize: 24)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextFill(
                controller: _textController,
                text: "Hỏi AI về môi trường...",
                hideText: false,
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Constants.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
