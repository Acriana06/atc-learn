import 'package:flutter/material.dart';
import 'constants/app_themes.dart';
import 'views/home/home_screen.dart';

void main() {
  runApp(const ATCLearnApp());
}

class ATCLearnApp extends StatelessWidget {
  const ATCLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATC Learn',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: const HomeScreen(),
    );
  }
}