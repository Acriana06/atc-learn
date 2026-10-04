import 'package:flutter/foundation.dart';
import '../services/supabase_service.dart';

class ModuleProgressData {
  final String moduleTitle;
  int attempts;
  int totalCorrect;
  int totalQuestions;

  ModuleProgressData({
    required this.moduleTitle,
    this.attempts = 0,
    this.totalCorrect = 0,
    this.totalQuestions = 0,
  });

  double get accuracy {
    if (totalQuestions == 0) return 0.0;
    return totalCorrect / totalQuestions;
  }

  String get bestScore => '$totalCorrect/$totalQuestions';
}

class ProgressProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Map<String, ModuleProgressData> _progressMap = {
    'Aerodrome Control': ModuleProgressData(moduleTitle: 'Aerodrome Control'),
    'Airspace Management': ModuleProgressData(moduleTitle: 'Airspace Management'),
    'Aviation Meteorology': ModuleProgressData(moduleTitle: 'Aviation Meteorology'),
  };

  List<ModuleProgressData> get allProgress => _progressMap.values.toList();

  Future<void> loadUserProgress() async {
    _isLoading = true;
    notifyListeners();

    try {
      final attempts = await _supabaseService.getUserQuizAttempts();

      for (var attempt in attempts) {
        final moduleData = attempt['modules'];
        if (moduleData == null) continue;

        final title = moduleData['title'] as String;
        final score = attempt['score'] as int;
        final total = attempt['total_questions'] as int;

        if (_progressMap.containsKey(title)) {
          final data = _progressMap[title]!;
          data.attempts++;
          if (score > data.totalCorrect) {
            data.totalCorrect = score;
            data.totalQuestions = total;
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading progress: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Made moduleId optional so your existing quiz_screen code doesn't throw argument errors
  Future<void> recordQuizAttempt(String moduleTitle, int score, int totalQuestions, {String? moduleId}) async {
    try {
      if (moduleId != null) {
        await _supabaseService.saveQuizAttempt(
          moduleId: moduleId,
          score: score,
          totalQuestions: totalQuestions,
        );
      }

      if (_progressMap.containsKey(moduleTitle)) {
        final data = _progressMap[moduleTitle]!;
        data.attempts++;
        if (score > data.totalCorrect) {
          data.totalCorrect = score;
          data.totalQuestions = totalQuestions;
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error saving quiz attempt: $e');
    }
  }
}