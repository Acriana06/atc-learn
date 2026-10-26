import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/app_state.dart'; // Make sure to import your AppStateManager
import 'views/auth/login_screen.dart';
import 'constants/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Supabase with your project credentials
  await Supabase.initialize(
    url: 'https://rboicreqcitwjpzbigpa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJib2ljcmVxY2l0d2pwemJpZ3BhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTExMzM1ODQsImV4cCI6MjEwNjcwOTU4NH0.RquMeMU_2lU6CUwRplsVkZJ6XsJWUcDe-X0t5BSDCu4',
  );

  // 2. Fetch all 9 official ICAO courses from Supabase on startup
  await AppStateManager.instance.fetchCoursesFromSupabase();

  runApp(const ATCLearnApp());
}

class ATCLearnApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  const ATCLearnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Agentic ATC Tutor',
          theme: AppTheme.lightAviationTheme,
          darkTheme: AppTheme.darkAviationTheme,
          themeMode: currentMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}