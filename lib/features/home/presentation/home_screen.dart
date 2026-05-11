import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'role': 'assistant', 'content': 'Hello Oswa! I am MediCura. How can I help you today?'}
  ];
  bool _isLoading = false;

  // --- LLM Logic (Groq + Llama 3) ---
  Future<void> sendMessageToLlama(String userText) async {
    if (userText.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': userText});
      _isLoading = true;
    });
    _messageController.clear();

    try {
      final dio = Dio();
      // !!! IMPORTANT: Paste your actual key here !!!
      const String apiKey = "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";

      final response = await dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(headers: {"Authorization": "Bearer $apiKey"}),
        data: {
          "model": "llama-3.1-8b-instant",
          "messages": [
            {
              "role": "system",
              "content": "You are MediCura, an empathetic medical assistant. Be supportive and concise."
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
      backgroundColor: const Color(0xFFF0F2F5), // WhatsApp-style light grey
      appBar: AppBar(
        backgroundColor: AppTheme.primaryTeal,
        title: const Text('MediCura AI', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat Message List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildChatBubble(_messages[index]),
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(color: AppTheme.primaryTeal, backgroundColor: Colors.transparent),
            ),

          // WhatsApp Style Input Field
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Map<String, String> msg) {
    bool isUser = msg['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFFDCF8C6) : Colors.white, // WhatsApp bubble colors
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isUser ? 15 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 15),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
          ],
        ),
        child: Text(
          msg['content']!,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: "Type a message",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppTheme.primaryTeal,
            radius: 24,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => sendMessageToLlama(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}