import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_colors.dart';
import '../../services/app_state.dart';

class ModuleDetailScreen extends StatefulWidget {
  final Map<String, dynamic> courseData;

  const ModuleDetailScreen({
    super.key,
    required this.courseData,
  });

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  bool _isLoadingQuiz = false;

  // Manual Timer State
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isStudying = false;

  void _toggleStudyTimer() {
    setState(() {
      if (_isStudying) {
        _stopwatch.stop();
        _timer?.cancel();
        _isStudying = false;

        final elapsed = _stopwatch.elapsed.inSeconds;
        if (elapsed > 2) {
          AppStateManager.instance.recordStudyTime(
            widget.courseData['id'],
            elapsed,
          );
          _showSnackBar('Saved ${elapsed}s of recorded study time!');
        }
      } else {
        _stopwatch.start();
        _isStudying = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      final elapsed = _stopwatch.elapsed.inSeconds;
      if (elapsed > 2) {
        AppStateManager.instance.recordStudyTime(
          widget.courseData['id'],
          elapsed,
        );
      }
    }
    super.dispose();
  }

  Future<void> _generateAndStartQuiz() async {
    setState(() => _isLoadingQuiz = true);

    try {
      debugPrint('Invoking quiz-generator Edge Function...');

      final response = await Supabase.instance.client.functions.invoke(
        'quiz-generator',
        body: {
          'courseTitle': widget.courseData['title'],
          'courseContent': widget.courseData['full_content'] ?? widget.courseData['description'],
        },
      );

      setState(() => _isLoadingQuiz = false);

      if (response.status == 200 && response.data != null) {
        final List dynamicQuiz = response.data['quiz'] ?? [];
        if (dynamicQuiz.isNotEmpty) {
          _showQuizModal(dynamicQuiz);
        } else {
          _showSnackBar('Could not generate quiz questions right now.');
        }
      } else {
        _showSnackBar('Quiz Engine Error: ${response.status}');
      }
    } catch (e) {
      debugPrint('ERROR invoking quiz-generator: $e');
      setState(() => _isLoadingQuiz = false);
      _showSnackBar('Connection Error: Unable to fetch dynamic quiz.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showQuizModal(List questions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0D122B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => InteractiveQuizSheet(
        courseId: widget.courseData['id'],
        courseCode: widget.courseData['code'] ?? '',
        questions: questions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    final title = widget.courseData['title'] ?? 'Module Detail';
    final code = widget.courseData['code'] ?? '';

    final rawContent = widget.courseData['full_content'] ?? widget.courseData['description'] ?? 'No content available.';
    final fullContent = rawContent.replaceAll(r'\n', '\n');

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutesStr = twoDigits(_stopwatch.elapsed.inMinutes.remainder(60));
    final secondsStr = twoDigits(_stopwatch.elapsed.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: Text(code.isNotEmpty ? '$code: $title' : title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                elevation: 1,
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isDarkMode
                      ? BorderSide(color: Colors.white.withOpacity(0.1), width: 1)
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: MarkdownBody(
                      data: fullContent,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontSize: 14, height: 1.5, color: textColor),
                        h1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                        h2: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                        listBullet: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Manual Interactive Study Timer Control Widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF141936) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _isStudying ? Colors.greenAccent : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: _isStudying ? Colors.greenAccent : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$minutesStr:$secondsStr',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _isStudying ? Colors.redAccent : AppColors.primary,
                      side: BorderSide(color: _isStudying ? Colors.redAccent : AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _toggleStudyTimer,
                    icon: Icon(_isStudying ? Icons.pause : Icons.play_arrow, size: 18),
                    label: Text(_isStudying ? 'Pause & Log' : 'Start Timer'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isLoadingQuiz ? null : _generateAndStartQuiz,
                icon: _isLoadingQuiz
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.auto_awesome, color: Colors.white),
                label: Text(
                  _isLoadingQuiz ? 'Generating AI Quiz...' : 'Take AI Generated Quiz',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Interactive Bottom Sheet Widget for Taking the Quiz
class InteractiveQuizSheet extends StatefulWidget {
  final String courseId;
  final String courseCode;
  final List questions;

  const InteractiveQuizSheet({
    super.key,
    required this.courseId,
    required this.courseCode,
    required this.questions,
  });

  @override
  State<InteractiveQuizSheet> createState() => _InteractiveQuizSheetState();
}

class _InteractiveQuizSheetState extends State<InteractiveQuizSheet> {
  final Map<int, int> _userAnswers = {};

  int get _score {
    int count = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_userAnswers[i] == widget.questions[i]['correctIndex']) {
        count++;
      }
    }
    return count;
  }

  void _finishAssessment() {
    AppStateManager.instance.recordQuizResult(
      widget.courseId,
      _score,
      widget.questions.length,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final allAnswered = _userAnswers.length == widget.questions.length;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assessment (${widget.courseCode})',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Score: $_score / ${widget.questions.length}',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF)),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: widget.questions.length,
              itemBuilder: (context, qIdx) {
                final q = widget.questions[qIdx];
                final List options = q['options'] ?? [];
                final selectedOption = _userAnswers[qIdx];
                final correctOption = q['correctIndex'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${qIdx + 1}. ${q['question']}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(options.length, (optIdx) {
                        final isSelected = selectedOption == optIdx;
                        final isCorrect = optIdx == correctOption;

                        Color borderColor = Colors.white12;
                        Color bgColor = const Color(0xFF141936);
                        IconData icon = Icons.circle_outlined;
                        Color iconColor = Colors.white38;

                        if (selectedOption != null) {
                          if (isSelected && isCorrect) {
                            borderColor = Colors.greenAccent;
                            bgColor = Colors.green.withOpacity(0.15);
                            icon = Icons.check_circle;
                            iconColor = Colors.greenAccent;
                          } else if (isSelected && !isCorrect) {
                            borderColor = Colors.redAccent;
                            bgColor = Colors.red.withOpacity(0.15);
                            icon = Icons.cancel;
                            iconColor = Colors.redAccent;
                          } else if (isCorrect) {
                            borderColor = Colors.greenAccent.withOpacity(0.5);
                            icon = Icons.check_circle_outline;
                            iconColor = Colors.greenAccent.withOpacity(0.7);
                          }
                        }

                        return InkWell(
                          onTap: () {
                            setState(() {
                              _userAnswers[qIdx] = optIdx;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1.0),
                            ),
                            child: Row(
                              children: [
                                Icon(icon, size: 18, color: iconColor),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    options[optIdx],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          if (allAnswered)
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _finishAssessment,
                child: const Text(
                  'Finish Assessment',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}