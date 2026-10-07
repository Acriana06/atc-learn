import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../quiz/quiz_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String moduleTitle;
  final String moduleDescription;

  const ModuleDetailScreen({
    super.key,
    required this.moduleTitle,
    required this.moduleDescription,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<String> lessons = [
      'Lesson 1: Introduction & Fundamentals',
      'Lesson 2: Standard Operating Procedures',
      'Lesson 3: Emergency Communication Protocols',
      'Lesson 4: Practical Case Studies',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(moduleTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description Card
            Card(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Module Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      moduleDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Course Lessons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            // Lessons List
            Expanded(
              child: ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.15)
                            : AppColors.textSecondary.withOpacity(0.2),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.secondary.withOpacity(0.1),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      title: Text(
                        lessons[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                      ),
                      onTap: () {
                        // TODO: Open specific lesson content
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(moduleTitle: moduleTitle),
                  ),
                );
              },
              icon: const Icon(Icons.quiz),
              label: const Text('Take Module Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}