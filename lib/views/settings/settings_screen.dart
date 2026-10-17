import 'package:flutter/material.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: ATCLearnApp.themeNotifier,
        builder: (context, currentMode, _) {
          final isDarkMode = currentMode == ThemeMode.dark;
          return ListView(
            children: [
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
                subtitle: Text(
                  'Toggle app theme',
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                value: isDarkMode,
                onChanged: (bool value) {
                  ATCLearnApp.themeNotifier.value =
                  value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}