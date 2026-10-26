import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_colors.dart';
import '../../providers/progress_provider.dart';
import '../../services/local_curriculum_repository.dart';
import '../auth/login_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Supabase.instance.client.auth.currentUser != null) {
        Provider.of<ProgressProvider>(context, listen: false).loadUserProgress();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentUser = Supabase.instance.client.auth.currentUser;
    const repository = LocalCurriculumRepository();
    final allCourses = repository.getAllCourses();

    if (currentUser == null) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 64, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(
                  'Please sign in to view your progress dashboard.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Go to Login'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Consumer<ProgressProvider>(
        builder: (context, progressProvider, child) {
          if (progressProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final progressList = progressProvider.allProgress;

          int totalQuestionsAttempted = 0;
          int totalCorrectAnswers = 0;
          int activeCoursesCount = 0;

          for (var p in progressList) {
            totalQuestionsAttempted += p.totalQuestions;
            totalCorrectAnswers += p.totalCorrect;
            if (p.totalQuestions > 0 || p.attempts > 0) {
              activeCoursesCount++;
            }
          }

          final double overallProficiency = totalQuestionsAttempted > 0
              ? (totalCorrectAnswers / totalQuestionsAttempted) * 100
              : 0.0;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Card: Overall Proficiency
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF001B94),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'OVERALL COURSE PROFICIENCY',
                        style: TextStyle(
                          color: Color(0xFF00E5FF),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: CircularProgressIndicator(
                              value: overallProficiency / 100,
                              strokeWidth: 8,
                              backgroundColor: Colors.white.withOpacity(0.15),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00E5FF)),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${overallProficiency.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                overallProficiency >= 75 ? 'ON TRACK' : 'NEEDS REVIEW',
                                style: const TextStyle(
                                  color: Color(0xFF00E5FF),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tracked across ${allCourses.length} ICAO training courses.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context: context,
                        icon: Icons.quiz_outlined,
                        iconColor: Colors.green,
                        value: '$totalQuestionsAttempted',
                        label: 'Questions Answered',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context: context,
                        icon: Icons.book_outlined,
                        iconColor: Colors.orange,
                        value: '$activeCoursesCount / ${allCourses.length}',
                        label: 'Active Courses',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Course Quiz Results Section Header
                Text(
                  'Course Assessment Results',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),

                // List Quiz Results Organized by Course
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allCourses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final course = allCourses[index];

                    // Match course modules against progress data
                    int courseTotalQ = 0;
                    int courseCorrectQ = 0;
                    for (var m in course.modules) {
                      final match = progressList.where((p) => p.moduleId == m.id);
                      if (match.isNotEmpty) {
                        courseTotalQ += match.first.totalQuestions;
                        courseCorrectQ += match.first.totalCorrect;
                      }
                    }

                    final double courseAccuracy = courseTotalQ > 0
                        ? (courseCorrectQ / courseTotalQ) * 100
                        : 0.0;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: isDarkMode ? Border.all(color: Colors.white12) : null,
                        boxShadow: isDarkMode
                            ? []
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${index + 1}. ${course.title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: isDarkMode ? Colors.white : const Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Text(
                                courseTotalQ > 0
                                    ? '$courseCorrectQ/$courseTotalQ (${courseAccuracy.toStringAsFixed(0)}%)'
                                    : 'Not Tested',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: courseTotalQ > 0
                                      ? (isDarkMode ? const Color(0xFF60A5FA) : const Color(0xFF1D4ED8))
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: courseAccuracy / 100,
                              minHeight: 8,
                              backgroundColor: isDarkMode ? Colors.white12 : const Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                courseAccuracy >= 75
                                    ? const Color(0xFF1D4ED8)
                                    : courseAccuracy >= 50
                                    ? Colors.orange
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDarkMode ? Border.all(color: Colors.white12) : null,
        boxShadow: isDarkMode
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.white60 : Colors.grey),
          ),
        ],
      ),
    );
  }
}