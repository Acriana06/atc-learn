import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class ModuleContentScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, String>> lessons;

  const ModuleContentScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.lessons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Overview Card
          Card(
            color: theme.colorScheme.primary.withOpacity(0.08),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Curriculum Overview', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: const TextStyle(fontSize: 14, height: 1.4)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Comprehensive Study Material',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Render each lesson with detailed body content
          ...List.generate(lessons.length, (index) {
            final lesson = lessons[index];
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: theme.colorScheme.primary,
                          child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            lesson['title'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Text(
                      lesson['content'] ?? '',
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          // Launch Exam Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
            },
            icon: const Icon(Icons.quiz),
            label: const Text('Take Module Certification Exam', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}