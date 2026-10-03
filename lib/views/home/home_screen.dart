import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:atc_learn/views/modules/module_detail_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATC Learn - Study Modules'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleModules.length,
        itemBuilder: (context, index) {
          final module = sampleModules[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                module['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  module['desc']!,
                  style: const TextStyle(color: AppColors.textSecondary),
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