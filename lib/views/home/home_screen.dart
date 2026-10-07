import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../main.dart'; // Import main.dart for ATCLearnApp.themeNotifier
import 'package:atc_learn/views/modules/module_detail_screen.dart';
import '../progress/progress_screen.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> sampleModules = const [
    {
      'title': 'Aerodrome Control',
      'desc': 'Tower procedures, runway operations, and ground movement.',
      'lessons': '5 Lessons'
    },
    {
      'title': 'Airspace Management',
      'desc': 'Classes of airspace, separation standards, and routing.',
      'lessons': '4 Lessons'
    },
    {
      'title': 'Aviation Meteorology',
      'desc': 'Weather patterns, METARs, TAFs, and hazardous weather.',
      'lessons': '6 Lessons'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ATC Learn - Study Modules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Account',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'View Progress',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgressScreen(),
                ),
              );
            },
          ),
          // Dynamic theme toggle icon that updates when clicked
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ATCLearnApp.themeNotifier,
            builder: (context, currentMode, child) {
              final isDark = currentMode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                tooltip: 'Toggle Theme',
                onPressed: () {
                  ATCLearnApp.themeNotifier.value =
                  isDark ? ThemeMode.light : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleModules.length,
        itemBuilder: (context, index) {
          final module = sampleModules[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            // Make the card background theme-aware
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              // Optional: add a subtle border in dark mode for extra definition
              side: isDarkMode
                  ? BorderSide(color: Colors.white.withOpacity(0.1), width: 1)
                  : BorderSide.none,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                module['title']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // Explicitly switches between custom primary color and high-contrast white
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  module['desc']!,
                  style: TextStyle(
                    // Explicitly switches subtitle contrast based on mode
                    color: isDarkMode ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
              ),
              trailing: Chip(
                label: Text(module['lessons']!),
                backgroundColor: AppColors.secondary.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppColors.secondary),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModuleDetailScreen(
                      moduleTitle: module['title']!,
                      moduleDescription: module['desc']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}