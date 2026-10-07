import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_colors.dart';
import '../../providers/progress_provider.dart';
import '../../services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  final String moduleTitle;

  const QuizScreen({super.key, required this.moduleTitle});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;

  void _selectAnswer(int index, List<Map<String, dynamic>> questions) {
    if (_answered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;
      if (index == questions[_currentQuestionIndex]['correct_answer_index']) {
        _score++;
      }
    });
  }

  void _nextQuestion(int totalQuestions) {
    setState(() {
      if (_currentQuestionIndex < totalQuestions - 1) {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _answered = false;
      } else {
        _showResultsDialog(totalQuestions);
      }
    });
  }

  void _showResultsDialog(int totalQuestions) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      try {
        await Provider.of<ProgressProvider>(context, listen: false).recordQuizAttempt(
          widget.moduleTitle,
          _score,
          totalQuestions,
        );
      } catch (e) {
        debugPrint('Error saving module progress: $e');
      }
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed! 🎉'),
        content: Text(
          'You scored $_score out of $totalQuestions in ${widget.moduleTitle}!',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.moduleTitle} Quiz'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _quizService.fetchQuestionsForModule(widget.moduleTitle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'No questions available for ${widget.moduleTitle} yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }

          final questions = snapshot.data!;
          final currentQuestion = questions[_currentQuestionIndex];
          final options = List<String>.from(currentQuestion['options']);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: isDarkMode
                        ? BorderSide(color: Colors.white.withOpacity(0.1), width: 1)
                        : BorderSide.none,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      currentQuestion['question_text'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final optionText = options[index];

                      Color cardColor = isDarkMode ? const Color(0xFF1E1E1E) : AppColors.surface;
                      Color borderColor = isDarkMode
                          ? Colors.white.withOpacity(0.15)
                          : AppColors.textSecondary.withOpacity(0.2);

                      if (_answered) {
                        if (index == currentQuestion['correct_answer_index']) {
                          cardColor = AppColors.success.withOpacity(0.25);
                          borderColor = AppColors.success;
                        } else if (index == _selectedAnswerIndex) {
                          cardColor = AppColors.error.withOpacity(0.25);
                          borderColor = AppColors.error;
                        }
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _selectAnswer(index, questions),
                          borderRadius: BorderRadius.circular(8),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: cardColor,
                              border: Border.all(color: borderColor, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              optionText,
                              style: TextStyle(
                                fontSize: 15,
                                color: isDarkMode ? Colors.white : AppColors.textPrimary,
                                fontWeight: index == currentQuestion['correct_answer_index'] && _answered
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_answered && currentQuestion['explanation'] != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Explanation: ${currentQuestion['explanation']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDarkMode ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: _answered ? () => _nextQuestion(questions.length) : null,
                  child: Text(
                    _currentQuestionIndex == questions.length - 1
                        ? 'View Results'
                        : 'Next Question',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}