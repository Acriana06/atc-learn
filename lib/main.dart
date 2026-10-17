import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/app_themes.dart'; // Your custom themes file
import 'providers/progress_provider.dart';
import 'views/main_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ATC Learn',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: currentMode,
          home: const MainLayout(),
        );
      },
    );
  }
}