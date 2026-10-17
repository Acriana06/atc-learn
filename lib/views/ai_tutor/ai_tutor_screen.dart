import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_colors.dart';

class AiTutorScreen extends StatefulWidget {
  final String moduleTitle;

  const AiTutorScreen({super.key, required this.moduleTitle});

  @override
  State<AiTutorScreen> createState() => _AiTutorScreenState();
}

class _AiTutorScreenState extends State<AiTutorScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add an initial greeting message from the AI tutor
    _messages.add({
      'role': 'ai',
      'text': 'Hello! I am your EATCA AI Study Tutor. Ask me anything about ${widget.moduleTitle}, regulations, or standard operating procedures!',
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    _controller.clear();
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });

    try {
      // Invoke your Supabase Edge Function securely
      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {
          'prompt': text,
          'moduleTitle': widget.moduleTitle,
        },
      );

      if (response.status == 200 && response.data != null) {
        final reply = response.data['reply'] ?? 'No response received.';
        setState(() {
          _messages.add({'role': 'ai', 'text': reply});
        });
      } else {
        throw Exception('Failed to fetch AI response');
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'ai',
          'text': 'Sorry, I encountered an error connecting to the tutor service. Please try again.',
        });
      });
      debugPrint('AI Tutor Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.moduleTitle} Tutor'),
      ),
      body: Column(
        children: [
          // Chat message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    padding: const EdgeInsets.all(14.0),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.primary
                          : (isDarkMode ? const Color(0xFF1E1E1E) : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      border: !isUser && isDarkMode
                          ? Border.all(color: Colors.white.withOpacity(0.1))
                          : null,
                      boxShadow: [
                        if (!isUser && !isDarkMode)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        fontSize: 15,
                        color: isUser
                            ? Colors.white
                            : (isDarkMode ? Colors.white : AppColors.textPrimary),
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          // Input bar
          Container(
            padding: const EdgeInsets.all(12.0),
            color: isDarkMode ? const Color(0xFF121212) : Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Ask a question about this module...',
                      filled: true,
                      fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
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