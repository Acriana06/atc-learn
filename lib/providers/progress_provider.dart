import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/local_curriculum_repository.dart';

class ModuleProgressData {
  final String moduleId;
  final String moduleTitle;
  int attempts;
  int totalCorrect;
  int totalQuestions;

  ModuleProgressData({
    required this.moduleId,
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
  final _supabase = Supabase.instance.client;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Pre-populate with all local courses/modules from LocalCurriculumRepository
  final Map<String, ModuleProgressData> _progressMap = {};

  ProgressProvider() {
    _initLocalModules();
  }

  void _initLocalModules() {
    const repo = LocalCurriculumRepository();
    for (var course in repo.getAllCourses()) {
      for (var mod in course.modules) {
        _progressMap[mod.id] = ModuleProgressData(
          moduleId: mod.id,
          moduleTitle: mod.title,
        );
      }
    }
  }

  List<ModuleProgressData> get allProgress => _progressMap.values.toList();

  Future<void> loadUserProgress() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Query quiz_attempts directly without table joins to prevent PGRST200 errors
      final response = await _supabase
          .from('quiz_attempts')
          .select()
          .eq('user_id', userId);

      final List<dynamic> attempts = response as List<dynamic>;

      // Reset counters before aggregation
      for (var entry in _progressMap.values) {
        entry.attempts = 0;
        entry.totalCorrect = 0;
        entry.totalQuestions = 0;
      }

      for (var attempt in attempts) {
        try {
          final moduleId = attempt['module_id']?.toString() ?? '';
          final score = (attempt['total_correct'] as num?)?.toInt() ?? 0;
          final total = (attempt['total_questions'] as num?)?.toInt() ?? 0;

          if (_progressMap.containsKey(moduleId)) {
            final data = _progressMap[moduleId]!;
            data.attempts++;
            if (score > data.totalCorrect || data.totalQuestions == 0) {
              data.totalCorrect = score;
              data.totalQuestions = total;
            }
          }
        } catch (itemError) {
          debugPrint('Error parsing individual attempt record: $itemError');
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error loading progress: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> recordQuizAttempt(String moduleId, int score, int totalQuestions) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId != null) {
        // Save directly to Supabase table without requiring complex relations
        await _supabase.from('quiz_attempts').insert({
          'user_id': userId,
          'module_id': moduleId,
          'total_correct': score,
          'total_questions': totalQuestions,
        });
      }

      if (_progressMap.containsKey(moduleId)) {
        final data = _progressMap[moduleId]!;
        data.attempts++;
        if (score > data.totalCorrect || data.totalQuestions == 0) {
          data.totalCorrect = score;
          data.totalQuestions = totalQuestions;
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving quiz attempt: $e');
    }
  }
}