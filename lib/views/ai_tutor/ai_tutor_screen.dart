import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../services/ai_service.dart';

class AiTutorScreen extends StatefulWidget {
  const AiTutorScreen({Key? key}) : super(key: key);

  @override
  State<AiTutorScreen> createState() => _AiTutorScreenState();
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _AiTutorScreenState extends State<AiTutorScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  final List<String> _quickPrompts = [
    "How do I issue a standard IFR departure clearance?",
    "What are standard vertical separation rules?",
    "Explain runway separation minima for arrivals",
    "Show me an example in Addis Ababa (HAAB) airspace"
  ];

  @override
  void initState() {
    super.initState();
    _addInitialGreeting();
  }

  void _addInitialGreeting() {
    _messages.add(
      ChatMessage(
        text: "**ATC Agent Online.**\nWelcome, Controller. Ask any global ICAO procedure, phraseology, or clearance question to begin.",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

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

  Future<void> _sendMessage([String? customPrompt]) async {
    final text = customPrompt ?? _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    if (customPrompt == null) {
      _controller.clear();
    }

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true;
    });

    _scrollToBottom();

    // Map existing history payload for context-aware multi-turn agent response
    final historyPayload = _messages
        .take(_messages.length - 1)
        .map((m) => ChatMessagePayload(text: m.text, isUser: m.isUser))
        .toList();

    final reply = await AiService.fetchAiTutorResponse(
      userPrompt: text,
      history: historyPayload,
    );

    setState(() {
      _isLoading = false;
      _messages.add(ChatMessage(
        text: reply ?? "Sorry, I couldn't reach the AI tutor right now. Please check your connection.",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });

    _scrollToBottom();
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
      _addInitialGreeting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.radar, color: Colors.cyanAccent),
            SizedBox(width: 8),
            Text("Agentic ATC Tutor"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: "Clear Session",
            onPressed: _clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _quickPrompts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final prompt = _quickPrompts[index];
                return ActionChip(
                  label: Text(
                    prompt,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.cyan.shade900,
                  side: const BorderSide(color: Colors.cyanAccent, width: 0.8),
                  onPressed: () => _sendMessage(prompt),
                );
              },
            ),
          ),
          const Divider(height: 1),

          // Message Stream
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.cyanAccent),
                  ),
                  SizedBox(width: 10),
                  Text("ATC Agent processing response...", style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Ask ATC Agent...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.send_rounded),
                  color: Colors.black,
                  style: IconButton.styleFrom(backgroundColor: Colors.cyanAccent),
                  onPressed: () => _sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          // High contrast dark blue-grey for assistant, deep cyan for user
          color: isUser ? Colors.cyan.shade800 : const Color(0xFF1E293B),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 2),
            bottomRight: Radius.circular(isUser ? 2 : 16),
          ),
          border: Border.all(
            color: isUser ? Colors.cyan.shade400 : Colors.blueGrey.shade600,
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isUser ? Icons.person : Icons.smart_toy,
                  size: 14,
                  color: isUser ? Colors.white70 : Colors.cyanAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  isUser ? "You" : "ATC Agent",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isUser ? Colors.white70 : Colors.cyanAccent,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 12, color: Colors.grey),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: msg.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard"), duration: Duration(seconds: 1)),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            isUser
                ? SelectableText(
              msg.text,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.white),
            )
                : MarkdownBody(
              data: msg.text,
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
                strong: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                code: const TextStyle(
                  backgroundColor: Colors.black54,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Colors.cyanAccent,
                ),
                codeblockDecoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}