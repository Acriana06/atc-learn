import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  bool _isFetchingHistory = true;

  final List<String> _quickTopics = [
    'Practice Readbacks',
    'Airspace Classes (A-G)',
    'VFR vs IFR Rules',
    'Emergency Phraseology',
    'Standard Taxi Clearances',
  ];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Load chat history from Supabase Postgres
  Future<void> _loadChatHistory() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => _isFetchingHistory = false);
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('chat_messages')
          .select('sender, content')
          .order('created_at', ascending: true);

      final loadedMessages = (response as List).map((msg) {
        return {
          'sender': msg['sender'].toString(),
          'text': msg['content'].toString(),
        };
      }).toList();

      setState(() {
        if (loadedMessages.isNotEmpty) {
          _messages = loadedMessages;
        } else {
          _messages = [
            {
              'sender': 'ai',
              'text':
              'Hello! Ask me any ATC phraseology or procedural question, or select a topic below to get started.'
            }
          ];
        }
      });
    } catch (e) {
      debugPrint('Error loading chat history: $e');
    } finally {
      setState(() => _isFetchingHistory = false);
      _scrollToBottom();
    }
  }

  // Save message to Supabase Postgres
  Future<void> _saveMessageToDb(String sender, String text) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      await Supabase.instance.client.from('chat_messages').insert({
        'user_id': user.id,
        'sender': sender,
        'content': text,
      });
    } catch (e) {
      debugPrint('Error saving message to DB: $e');
    }
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
      _messages.add({'sender': 'user', 'text': text});
      _isLoading = true;
    });

    _scrollToBottom();
    await _saveMessageToDb('user', text);

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {'prompt': text},
      );

      final data = response.data;
      String aiResponse = 'Unable to parse AI response.';

      if (data != null &&
          data['choices'] != null &&
          data['choices'].isNotEmpty) {
        aiResponse = data['choices'][0]['message']['content'];
      }

      setState(() {
        _messages.add({'sender': 'ai', 'text': aiResponse});
      });

      await _saveMessageToDb('ai', aiResponse);
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text': 'Error: Failed to fetch response from AI tutor.'
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ATC Tutor AI',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 110.0),
        child: FloatingActionButton.small(
          backgroundColor: theme.colorScheme.primaryContainer,
          foregroundColor: theme.colorScheme.onPrimaryContainer,
          onPressed: _scrollToBottom,
          child: const Icon(Icons.arrow_downward),
        ),
      ),
      body: _isFetchingHistory
          ? Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
        ),
      )
          : Column(
        children: [
          // Chat Message List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth:
                      MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isUser
                        ? Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        color:
                        theme.colorScheme.onPrimaryContainer,
                      ),
                    )
                        : MarkdownBody(
                      data: message['text'] ?? '',
                      selectable: true,
                      styleSheet: MarkdownStyleSheet.fromTheme(
                          theme)
                          .copyWith(
                        p: TextStyle(
                            color: theme
                                .colorScheme.onSurfaceVariant),
                        h1: TextStyle(
                            color: theme.colorScheme.onSurface),
                        h2: TextStyle(
                            color: theme.colorScheme.onSurface),
                        h3: TextStyle(
                            color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),

          // Quick Topic Suggestion Chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              scrollDirection: Axis.horizontal,
              itemCount: _quickTopics.length,
              separatorBuilder: (context, index) =>
              const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final topic = _quickTopics[index];
                return ActionChip(
                  label: Text(
                    topic,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  backgroundColor:
                  theme.colorScheme.surfaceContainerLow,
                  side: BorderSide(
                      color: theme.colorScheme.outlineVariant),
                  onPressed:
                  _isLoading ? null : () => _sendMessage(topic),
                );
              },
            ),
          ),

          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              style: TextStyle(color: theme.colorScheme.onSurface),
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: 'Ask about air traffic control procedures...',
                hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send,
                      color: theme.colorScheme.primary),
                  onPressed: () => _sendMessage(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}