import 'package:flutter/material.dart';
import '../../services/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppStateManager.instance.addListener(_updateView);
  }

  @override
  void dispose() {
    AppStateManager.instance.removeListener(_updateView);
    super.dispose();
  }

  void _updateView() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final state = AppStateManager.instance;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF141936) : Colors.white;

    final activeCourses = state.allCourses.where((c) => (c['status'] ?? 'Not Started') != 'Not Started').toList();

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Live Metrics Header
        Row(
          children: [
            Expanded(child: _metricCard('Completed', '${state.completedCoursesCount} / ${state.allCourses.length}', Icons.task_alt, Colors.cyan, cardBg)),
            const SizedBox(width: 10),
            Expanded(child: _metricCard('Study Hours', '${state.totalStudyHours.toStringAsFixed(1)}h', Icons.timer_outlined, Colors.orangeAccent, cardBg)),
            const SizedBox(width: 10),
            Expanded(child: _metricCard('Pass Rate', '${state.overallPassRate.toStringAsFixed(1)}%', Icons.verified, Colors.green, cardBg)),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Enrolled & Active Courses', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...activeCourses.map((course) {
          final double progress = (course['progress'] ?? 0.0).toDouble();
          final int progressPct = (progress * 100).toInt();

          return Card(
            color: cardBg,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(course['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Status: ${course['status'] ?? 'In Progress'} | Progress: $progressPct%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        }),
        if (activeCourses.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'No courses started yet. Head over to the ICAO Courses tab to enroll!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _metricCard(String label, String value, IconData icon, Color accent, Color cardBg) {
    return Card(
      color: cardBg,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}