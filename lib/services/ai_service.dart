import 'package:supabase_flutter/supabase_flutter.dart';

/// Data structure for passing past messages to the Edge Function context
class ChatMessagePayload {
  final String text;
  final bool isUser;

  ChatMessagePayload({
    required this.text,
    required this.isUser,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
  };
}

class AiService {
  /// Invokes the `ai-tutor` Supabase Edge Function with multi-turn history
  static Future<String?> fetchAiTutorResponse({
    required String userPrompt,
    List<ChatMessagePayload> history = const [],
  }) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {
          'prompt': userPrompt,
          'history': history.map((e) => e.toJson()).toList(),
        },
      );

      final data = response.data;

      if (data != null && data is Map && data['reply'] != null) {
        return data['reply'] as String;
      }
    } catch (e) {
      print('AI Service Error: $e');
    }
    return null;
  }
}