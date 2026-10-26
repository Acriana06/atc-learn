import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _audioCuesEnabled = true;
  bool _offlineMode = false;
  bool _pushNotifications = true;
  String _selectedAltimeterUnit = 'hPa';
  String _selectedWindUnit = 'Knots (kts)';
  String _phraseologyStandard = 'ICAO Standard';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('Appearance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Card(
          child: SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(isDarkMode ? 'Active: Navy & Aviation Dark' : 'Active: Clean Light Theme'),
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            value: isDarkMode,
            onChanged: (bool value) {
              setState(() {
                ATCLearnApp.themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        const Text('Aviation Preferences', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('ATC Voice & Audio Cues'),
                subtitle: const Text('Play audio indicators during quizzes'),
                secondary: const Icon(Icons.volume_up),
                value: _audioCuesEnabled,
                onChanged: (val) => setState(() => _audioCuesEnabled = val),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Phraseology Standard'),
                subtitle: Text('Current: $_phraseologyStandard'),
                trailing: DropdownButton<String>(
                  value: _phraseologyStandard,
                  items: const [
                    DropdownMenuItem(value: 'ICAO Standard', child: Text('ICAO Standard')),
                    DropdownMenuItem(value: 'FAA / US Standard', child: Text('FAA / US Standard')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _phraseologyStandard = val);
                  },
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Altimeter Unit'),
                subtitle: Text('Current: $_selectedAltimeterUnit'),
                trailing: DropdownButton<String>(
                  value: _selectedAltimeterUnit,
                  items: const [
                    DropdownMenuItem(value: 'hPa', child: Text('hPa')),
                    DropdownMenuItem(value: 'inHg', child: Text('inHg')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedAltimeterUnit = val);
                  },
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text('Wind Speed Unit'),
                subtitle: Text('Current: $_selectedWindUnit'),
                trailing: DropdownButton<String>(
                  value: _selectedWindUnit,
                  items: const [
                    DropdownMenuItem(value: 'Knots (kts)', child: Text('Knots (kts)')),
                    DropdownMenuItem(value: 'Meters/sec (m/s)', child: Text('m/s')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedWindUnit = val);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Text('System & Account', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Offline Training Cache'),
                subtitle: const Text('Save modules locally for offline study'),
                secondary: const Icon(Icons.cloud_download),
                value: _offlineMode,
                onChanged: (val) => setState(() => _offlineMode = val),
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Daily training reminders'),
                secondary: const Icon(Icons.notifications),
                value: _pushNotifications,
                onChanged: (val) => setState(() => _pushNotifications = val),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                subtitle: const Text('End active session'),
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully signed out.')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Center(
          child: Text(
            'Agentic ATC Tutor • Ethiopian Air Traffic Control\nVersion 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}