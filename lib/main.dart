import 'package:flutter/material.dart';

void main() {
  runApp(const AtcLearnApp());
}

class AtcLearnApp extends StatelessWidget {
  const AtcLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATC Learn',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue[300] ,
      appBar: AppBar(
        title: const Text('ATC Learn'),
      ),
      body: const Center(
        child: Text(
          'Welcome to ATC Learn!\nStudy modules and take quizzes.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}