// lib/services/ai_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class AiService {
  static Future<String?> fetchAiTutorResponse(String userPrompt) async {
    try {
      final response = await Supabase.instance.client.functions.invoke(
        'ai-tutor',
        body: {
          'prompt': userPrompt,
        },
      );

      final data = response.data;
      if (data != null && data['choices'] != null && data['choices'].isNotEmpty) {
        return data['choices'][0]['message']['content'] as String;
      }
    } catch (error) {
      print('Error calling AI Tutor function: $error');
    }
    return null;
  }
}