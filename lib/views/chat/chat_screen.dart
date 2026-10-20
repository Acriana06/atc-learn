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
  List<Map<String, dynamic>> _sessions = [];
  String? _currentSessionId;

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
    _initializeChatSessions();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch all chat sessions for the user
  Future<void> _initializeChatSessions() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => _isFetchingHistory = false);
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('chat_sessions')
          .select('id, title, created_at')
          .order('created_at', ascending: false);

      final sessionsList = List<Map<String, dynamic>>.from(response);

      setState(() {
        _sessions = sessionsList;
      });

      if (_sessions.isNotEmpty) {
        // Load the most recent session by default
        await _loadSessionMessages(_sessions.first['id']);
      } else {
        // Create a new session if none exist
        await _createNewSession(initialMessage: false);
      }
    } catch (e) {
      debugPrint('Error loading chat sessions: $e');
      setState(() => _isFetchingHistory = false);
    }
  }

  // Create a brand new chat session
  Future<void> _createNewSession({bool initialMessage = true}) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      final response = await Supabase.instance.client
          .from('chat_sessions')
          .insert({
        'user_id': user.id,
        'title': 'New Chat',
      })
          .select()
          .single();

      setState(() {
        _sessions.insert(0, response);
        _currentSessionId = response['id'];
        _messages = [
          {
            'sender': 'ai',
            'text':
            'Hello! Ask me any ATC phraseology or procedural question, or select a topic below to get started.'
          }
        ];
        _isFetchingHistory = false;
      });
    } catch (e) {
      debugPrint('Error creating session: $e');
    }
  }

  // Load messages for a specific session ID
  Future<void> _loadSessionMessages(String sessionId) async {
    setState(() {
      _currentSessionId = sessionId;
      _isFetchingHistory = true;
    });

    try {
      final response = await Supabase.instance.client
          .from('chat_messages')
          .select('sender, content')
          .eq('session_id', sessionId)
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
      debugPrint('Error loading session messages: $e');
    } finally {
      setState(() => _isFetchingHistory = false);
      _scrollToBottom();
    }
  }

  // Save message to Supabase Postgres bound to current session
  Future<void> _saveMessageToDb(String sender, String text) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null || _currentSessionId == null) return;

    try {
      await Supabase.instance.client.from('chat_messages').insert({
        'session_id': _currentSessionId,
        'user_id': user.id,
        'sender': sender,
        'content': text,
      });

      // If it's the first user message, update the session title to match text preview
      if (sender == 'user' && _messages.where((m) => m['sender'] == 'user').length == 1) {
        final title = text.length > 25 ? '${text.substring(0, 25)}...' : text;
        await Supabase.instance.client
            .from('chat_sessions')
            .update({'title': title})
            .eq('id', _currentSessionId!);

        setState(() {
          final sessionIndex = _sessions.indexWhere((s) => s['id'] == _currentSessionId);
          if (sessionIndex != -1) {
            _sessions[sessionIndex]['title'] = title;
          }
        });
      }
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
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      drawer: Drawer(
        backgroundColor: theme.colorScheme.surface,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 40, color: theme.colorScheme.primary),
                    const SizedBox(height: 10),
                    Text(
                      'Chat Sessions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Close drawer
                  _createNewSession();
                },
                icon: const Icon(Icons.add),
                label: const Text('New Chat'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final session = _sessions[index];
                  final isSelected = session['id'] == _currentSessionId;

                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    leading: Icon(Icons.history,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant),
                    title: Text(
                      session['title'] ?? 'Untitled Chat',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      _loadSessionMessages(session['id']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
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