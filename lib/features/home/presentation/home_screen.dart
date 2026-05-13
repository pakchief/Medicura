import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'role': 'assistant', 'content': 'Hello! I am MediCura. How can I help you today?'}
  ];
  bool _isLoading = false;

  // --- LLM Logic (Your Groq + Llama 3 Integration) ---
  Future<void> sendMessageToLlama(String userText) async {
    if (userText.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': userText});
      _isLoading = true;
    });
    _messageController.clear();

    try {
      final dio = Dio();
      // Use your actual Groq API Key here
      const String apiKey = "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";

      final response = await dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(headers: {"Authorization": "Bearer $apiKey"}),
        data: {
          "model": "llama-3.1-8b-instant",
          "messages": [
            {
              "role": "system",
              "content": "You are MediCura, an empathetic medical assistant for a user. Be supportive and concise."
            },
            ..._messages.map((m) => {"role": m['role'], "content": m['content']}),
          ],
        },
      );

      setState(() {
        _messages.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Check your API Key or Internet.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. TOP AVATAR HEADER (From image_1ca6f9.png)
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatarimage.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.menu, color: Color(0xFF4DD0E1)), onPressed: () {}),
                      Image.asset('assets/images/Medicuratext.png', height: 40),
                      IconButton(icon: const Icon(Icons.notifications, color: Color(0xFF4DD0E1)), onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 2. CHAT MESSAGES
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(msg['content']!, msg['role'] == 'user');
              },
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: CircularProgressIndicator(color: AppTheme.primaryTeal),
            ),

          // 3. GRADIENT INPUT AREA
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E93B9), Color(0xFF4FD1C5)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(Icons.add_circle_outline, color: Colors.white70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Ask Anything',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onSubmitted: sendMessageToLlama,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => sendMessageToLlama(_messageController.text),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF2E93B9) : const Color(0xFFE6F7FA),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}