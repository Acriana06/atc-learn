import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Save a quiz attempt to Supabase
  Future<void> saveQuizAttempt({
    required String moduleId,
    required int score,
    required int totalQuestions,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final percentage = (score / totalQuestions) * 100;

    await _supabase.from('quiz_attempts').insert({
      'user_id': user.id,
      'module_id': moduleId,
      'score': score,
      'total_questions': totalQuestions,
      'percentage': percentage,
    });
  }

  // Fetch all quiz attempts for the current user
  Future<List<Map<String, dynamic>>> getUserQuizAttempts() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final response = await _supabase
        .from('quiz_attempts')
        .select('*, modules(title)')
        .eq('user_id', user.id);

    return List<Map<String, dynamic>>.from(response);
  }
}