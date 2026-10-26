import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_colors.dart';
import '../../providers/progress_provider.dart';
import '../../services/local_curriculum_repository.dart';
import '../modules/module_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgressProvider>(context, listen: false).loadUserProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    const repository = LocalCurriculumRepository();
    final allCourses = repository.getAllCourses();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // No duplicate AppBar here since the main layout wrapper handles navigation/appbar
      body: Consumer<ProgressProvider>(
        builder: (context, progressProvider, child) {
          if (progressProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Aggregate progress by Course ID
          final progressMap = progressProvider.allProgress;

          // Filter courses that have actual attempts or study time
          final startedCourses = allCourses.where((course) {
            return course.modules.any((module) {
              final match = progressMap.where((p) => p.moduleId == module.id).toList();
              return match.isNotEmpty && (match.first.totalQuestions > 0 || match.first.attempts > 0);
            });
          }).toList();

          return RefreshIndicator(
            onRefresh: () => progressProvider.loadUserProgress(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Stats Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          context: context,
                          icon: Icons.check_circle_outline,
                          iconColor: Colors.blue,
                          value: '${startedCourses.length} / ${allCourses.length}',
                          label: 'Active Courses',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          context: context,
                          icon: Icons.timer_outlined,
                          iconColor: Colors.orange,
                          value: 'Active',
                          label: 'Study Timer Status',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Section Header
                  Text(
                    'Your Enrolled & Started Courses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Started Courses List or Empty State
                  startedCourses.isEmpty
                      ? Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? Colors.white12 : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.menu_book, size: 48, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(
                          'No courses started yet.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDarkMode ? Colors.white : const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Head over to "ICAO Courses" in the navigation drawer to select and start your training.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: startedCourses.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final course = startedCourses[index];

                      // Find first module or aggregate score for the course
                      final firstModule = course.modules.isNotEmpty ? course.modules.first : null;
                      final progressMatch = firstModule != null
                          ? progressMap.where((p) => p.moduleId == firstModule.id).toList()
                          : [];
                      final progress = progressMatch.isNotEmpty ? progressMatch.first : null;
                      final int totalQ = progress?.totalQuestions ?? 0;
                      final int correctQ = progress?.totalCorrect ?? 0;
                      final double accuracy = totalQ > 0 ? (correctQ / totalQ) * 100 : 0.0;

                      return Container(
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
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            course.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              totalQ > 0
                                  ? 'Latest Quiz Score: $correctQ/$totalQ (${accuracy.toStringAsFixed(0)}%)'
                                  : 'Course in progress',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
                          onTap: () {
                            if (firstModule != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModuleDetailScreen(
                                    courseId: course.id,
                                    moduleId: firstModule.id,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard({
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