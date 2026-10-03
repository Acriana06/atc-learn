import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_provider.dart';

class QuizScreen extends StatefulWidget {
  final String moduleTitle;

  const QuizScreen({super.key, required this.moduleTitle});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;

  List<Map<String, dynamic>> get _questions {
    if (widget.moduleTitle == 'Aerodrome Control') {
      return [
        {
          'question': 'What is the primary responsibility of an Aerodrome Controller?',
          'options': [
            'Issuing en-route flight clearances',
            'Preventing collisions on the maneuvering area and runway',
            'Forecasting terminal weather patterns',
            'Maintaining aircraft cruising altitudes'
          ],
          'correctAnswerIndex': 1,
          'explanation': 'Aerodrome controllers manage traffic on and around the airport, focusing heavily on runway safety.'
        },
      ];
    } else if (widget.moduleTitle == 'Airspace Management') {
      return [
        {
          'question': 'Which airspace classification typically requires an ATC clearance for all flights?',
          'options': [
            'Class G',
            'Class E',
            'Class B',
            'Class F'
          ],
          'correctAnswerIndex': 2,
          'explanation': 'Class B airspace surrounds major airports and strictly requires an air traffic control clearance.'
        },
      ];
    } else {
      return [
        {
          'question': 'What does the acronym METAR stand for in aviation meteorology?',
          'options': [
            'Meteorological Terminal Air Report',
            'Meteorological Aerodrome Report',
            'Meteorological Routine Airfield Report',
            'Meteorological Aerodrome Routine Weather Report'
          ],
          'correctAnswerIndex': 3,
          'explanation': 'METAR stands for Aerodrome Routine Meteorological Report.'
        },
      ];
    }
  }

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex]['correctAnswerIndex']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _answered = false;
      } else {
        _showResultsDialog();
      }
    });
  }

  void _showResultsDialog() {
    // Record the attempt in the provider
    Provider.of<ProgressProvider>(context, listen: false)
        .recordQuizAttempt(widget.moduleTitle, _score, _questions.length);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed! 🎉'),
        content: Text(
          'You scored $_score out of ${_questions.length}!',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.moduleTitle} Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  currentQuestion['question'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: (currentQuestion['options'] as List).length,
                itemBuilder: (context, index) {
                  final optionText = currentQuestion['options'][index];

                  Color cardColor = AppColors.surface;
                  Color borderColor = AppColors.textSecondary.withOpacity(0.2);

                  if (_answered) {
                    if (index == currentQuestion['correctAnswerIndex']) {
                      cardColor = AppColors.success.withOpacity(0.15);
                      borderColor = AppColors.success;
                    } else if (index == _selectedAnswerIndex) {
                      cardColor = AppColors.error.withOpacity(0.15);
                      borderColor = AppColors.error;
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => _selectAnswer(index),
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
                            color: AppColors.textPrimary,
                            fontWeight: index == currentQuestion['correctAnswerIndex'] && _answered
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

            // Explanation Section (shown after answering)
            if (_answered) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Explanation: ${currentQuestion['explanation']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Next / Continue Button
            ElevatedButton(
              onPressed: _answered ? _nextQuestion : null,
              child: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? 'View Results'
                    : 'Next Question',
              ),
            ),
          ],
        ),
      ),
    );
  }
}