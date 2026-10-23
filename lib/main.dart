import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/progress_provider.dart';
import 'views/main_layout.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rboicreqcitwjpzbigpa.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJib2ljcmVxY2l0d2pwemJpZ3BhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTExMzM1ODQsImV4cCI6MjEwNjcwOTU4NH0.RquMeMU_2lU6CUwRplsVkZJ6XsJWUcDe-X0t5BSDCu4',
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
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'ATC Learn',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
          ),
          home: StreamBuilder<AuthState>(
            stream: Supabase.instance.client.auth.onAuthStateChange,
            builder: (context, snapshot) {
              final session = Supabase.instance.client.auth.currentSession;
              if (session != null) {
                return const MainLayout();
              }
              return const LoginScreen();
            },
          ),
        );
      },
    );
  }
}