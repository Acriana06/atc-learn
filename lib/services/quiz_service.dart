import 'package:supabase_flutter/supabase_flutter.dart';

class QuizService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchQuestionsForModule(String moduleTitle) async {
    try {
      print('🔍 Searching for module title: "$moduleTitle"');

      // 1. Find the module ID matching the title safely
      final moduleResponse = await _supabase
          .from('modules')
          .select('id')
          .eq('title', moduleTitle)
          .maybeSingle(); // Returns null instead of throwing if no match

      if (moduleResponse == null) {
        print('❌ No module found matching title: "$moduleTitle"');
        return [];
      }

      final moduleId = moduleResponse['id'];
      print('✅ Found module ID: $moduleId. Fetching questions...');

      // 2. Fetch questions linked to that module ID
      final questionsResponse = await _supabase
          .from('questions')
          .select('*')
          .eq('module_id', moduleId);

      return List<Map<String, dynamic>>.from(questionsResponse);
    } catch (e) {
      print('❌ Error fetching questions: $e');
      return [];
    }
  }
}