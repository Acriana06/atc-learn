import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/app_state.dart';
import 'providers/progress_provider.dart';
import 'views/auth/login_screen.dart';
import 'views/main_layout.dart';
import 'constants/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Supabase.initialize(
    url: 'https://rboicreqcitwjpzbigpa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJib2ljcmVxY2l0d2pwemJpZ3BhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTExMzM1ODQsImV4cCI6MjEwNjcwOTU4NH0.RquMeMU_2lU6CUwRplsVkZJ6XsJWUcDe-X0t5BSDCu4',
  );

  //  Fetch all official ICAO courses from Supabase on startup
  await AppStateManager.instance.fetchCoursesFromSupabase();

  runApp(const ATCLearnApp());
}

class ATCLearnApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  const ATCLearnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if an active user session already exists on device storage
    final session = Supabase.instance.client.auth.currentSession;

    //  Wrap the entire app in MultiProvider so ALL screens can access ProgressProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Agentic ATC Tutor',
            theme: AppTheme.lightAviationTheme,
            darkTheme: AppTheme.darkAviationTheme,
            themeMode: currentMode,
            // Open MainLayoutScreen if session is active; otherwise start at LoginScreen
            home: session != null ? const MainLayoutScreen() : const LoginScreen(),
          );
        },
      ),
    );
  }
}
