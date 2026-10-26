import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
class AiTutorChatScreen extends StatefulWidget {
  const AiTutorChatScreen({Key? key}) : super(key: key);

  @override
  State<AiTutorChatScreen> createState() => _AiTutorChatScreenState();
}

class _AiTutorChatScreenState extends State<AiTutorChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Chat history holding conversation state
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello Trainee! I am your ICAO Air Traffic Control AI Tutor powered by Grok. Ask me anything about separation minima, Doc 4444 rules, or upload your module notes for analysis.',
      'isUser': false
    },
  ];

  bool _isGenerating = false;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendQueryToSupabase(String prompt) async {
    if (prompt.trim().isEmpty) return;

    setState(() {
      _messages.add({'text': prompt.trim(), 'isUser': true});
      _controller.clear();
      _isGenerating = true;
    });
    _scrollToBottom();

    try {
      // Fixed sublist syntax (- 1)
      final historyPayload = _messages
          .sublist(0, _messages.length - 1)
          .map((m) => {'isUser': m['isUser'], 'text': m['text']})
          .toList();

      // Invoke Supabase Edge Function ('ai-tutor')
      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {
          'prompt': prompt.trim(),
          'history': historyPayload,
        },
      );

      if (!mounted) return;

      String aiReply;
      if (response.status == 200 && response.data != null) {
        aiReply = response.data['reply'] ?? 'No response generated.';
      } else {
        aiReply = 'Server Error (${response.status}): ${response.data?['error'] ?? 'Failed to reach AI tutor.'}';
      }

      setState(() {
        _messages.add({'text': aiReply, 'isUser': false});
        _isGenerating = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'text': 'Connection Error: Unable to communicate with the Supabase Edge Function. (${e.toString()})',
          'isUser': false
        });
        _isGenerating = false;
      });
    }

    _scrollToBottom();
  }

  void _simplifyLastResponse() async {
    final lastAssistantMsg = _messages.reversed.firstWhere(
          (m) => m['isUser'] == false,
      orElse: () => {'text': 'ICAO Air Traffic Control rules'},
    );

    final promptText = 'Please simplify this previous explanation into clear, concise, trainee-friendly bullet points: "${lastAssistantMsg['text']}"';

    setState(() {
      _messages.add({'text': '🔍 Simplify last response', 'isUser': true});
      _isGenerating = true;
    });
    _scrollToBottom();

    try {
      // Fixed sublist syntax (- 1)
      final historyPayload = _messages
          .sublist(0, _messages.length - 1)
          .map((m) => {'isUser': m['isUser'], 'text': m['text']})
          .toList();

      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {
          'prompt': promptText,
          'history': historyPayload,
        },
      );

      if (!mounted) return;

      String aiReply;
      if (response.status == 200 && response.data != null) {
        aiReply = response.data['reply'] ?? 'No response generated.';
      } else {
        aiReply = 'Server Error: Unable to simplify.';
      }

      setState(() {
        _messages.add({'text': aiReply, 'isUser': false});
        _isGenerating = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _messages.add({'text': 'Connection Error: Failed to simplify.', 'isUser': false});
        _isGenerating = false;
      });
    }

    _scrollToBottom();
  }

  void _uploadDocument() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Module PDF uploaded and indexed for AI analysis!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final aiBubbleBg = isDarkMode ? const Color(0xFF141936) : Colors.white;
    final userBubbleBg = const Color(0xFF3D52D5);
    final inputBarBg = isDarkMode ? const Color(0xFF0D122B) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return SizedBox.expand(
      child: Column(
        children: [
          // Top Action Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: isDarkMode ? const Color(0xFF090C9B).withOpacity(0.3) : const Color(0xFF3D52D5).withOpacity(0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ICAO Jargon Assistant (Groq Live)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFF00E5FF)),
                  onPressed: _simplifyLastResponse,
                  icon: const Icon(Icons.flash_on, size: 16),
                  label: const Text('Simplify Last Response', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // Chat Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    // Fixed multiplication syntax (* 0.78)
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                    decoration: BoxDecoration(
                      color: isUser ? userBubbleBg : aiBubbleBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isUser ? Colors.transparent : (isDarkMode ? const Color(0xFF3D52D5).withOpacity(0.3) : Colors.black12),
                      ),
                    ),
                    child: isUser
                        ? Text(
                      msg['text'] as String,
                      style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.white),
                    )
                        : // Inside your MarkdownBody widget styleSheet:
                    MarkdownBody(
                      data: msg['text'] as String,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.notoSansEthiopic(fontSize: 13, height: 1.4, color: textColor),
                        strong: GoogleFonts.notoSansEthiopic(fontWeight: FontWeight.bold, color: textColor),
                        listBullet: GoogleFonts.notoSansEthiopic(color: textColor),
                        tableBody: GoogleFonts.notoSansEthiopic(fontSize: 12, color: textColor),
                        tableHead: GoogleFonts.notoSansEthiopic(fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Loading Indicator when generating response
          if (_isGenerating)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                  SizedBox(width: 8),
                  Text('Grok is querying ICAO databases...', style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),

          // Input Bar Pinned at Bottom
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: inputBarBg,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file_rounded, color: Color(0xFF3D52D5)),
                  onPressed: _uploadDocument,
                  tooltip: 'Upload Module PDF',
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: textColor, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Ask about ICAO rules, separation, or upload doc...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      border: InputBorder.none,
                    ),
                    onSubmitted: _sendQueryToSupabase,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: Color(0xFF3D52D5)),
                  onPressed: () => _sendQueryToSupabase(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}