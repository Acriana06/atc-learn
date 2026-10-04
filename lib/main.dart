import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import 'constants/app_themes.dart';
import 'providers/progress_provider.dart';
import 'views/home/home_screen.dart';

Future<void> main() async {
  // 1. Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Supabase (replacing Firebase)
  await Supabase.initialize(
    url: 'https://rboicreqcitwjpzbigpa.supabase.co',
    publishableKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJib2ljcmVxY2l0d2pwemJpZ3BhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTExMzM1ODQsImV4cCI6MjEwNjcwOTU4NH0.RquMeMU_2lU6CUwRplsVkZJ6XsJWUcDe-X0t5BSDCu4',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: const ATCLearnApp(),
    ),
  );
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