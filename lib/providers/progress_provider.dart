import 'package:flutter/foundation.dart';

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
  // Initial tracker data for our modules
  final Map<String, ModuleProgressData> _progressMap = {
    'Aerodrome Control': ModuleProgressData(moduleTitle: 'Aerodrome Control'),
    'Airspace Management': ModuleProgressData(moduleTitle: 'Airspace Management'),
    'Aviation Meteorology': ModuleProgressData(moduleTitle: 'Aviation Meteorology'),
  };

  List<ModuleProgressData> get allProgress => _progressMap.values.toList();

  ModuleProgressData getProgressForModule(String title) {
    return _progressMap[title] ?? ModuleProgressData(moduleTitle: title);
  }

  void recordQuizAttempt(String moduleTitle, int score, int totalQuestions) {
    if (_progressMap.containsKey(moduleTitle)) {
      final data = _progressMap[moduleTitle]!;
      data.attempts++;
      // Keep the best score or aggregate total correct
      if (score > data.totalCorrect) {
        data.totalCorrect = score;
        data.totalQuestions = totalQuestions;
      }
      notifyListeners();
    }
  }
}