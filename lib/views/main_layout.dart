import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home/home_screen.dart';
import 'modules/module_list_screen.dart';
import 'ai_tutor/ai_tutor_screen.dart';
import '../views/progress/progress_screen.dart';
import 'profile/profile_screen.dart';
import 'settings/settings_screen.dart';
import '../providers/progress_provider.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ModuleListScreen(),
    AiTutorChatScreen(),
    ProgressScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = [
    'ATC Training Dashboard',
    'ICAO Course Curriculum',
    'AI ATC Study Assistant',
    'Trainee Progress & Metrics',
    'Student Cadet Profile',
    'System Settings',
  ];

  @override
  void initState() {
    super.initState();
    // Listen to Supabase Auth state changes (Sign In / Sign Out)
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (mounted) {
        // Trigger data fetch for user metrics on auth change
        if (data.session != null) {
          Provider.of<ProgressProvider>(context, listen: false).loadUserProgress();
        }
        setState(() {}); // Rebuild layout to reflect auth change
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final drawerBg = isDarkMode ? const Color(0xFF0A0D1E) : Colors.white;
    final drawerTextColor = isDarkMode ? Colors.white : Colors.black87;

    final currentUser = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      drawer: Drawer(
        backgroundColor: drawerBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF090C9B)),
              accountName: Text(
                currentUser != null ? 'Cadet Captain' : 'Guest Cadet',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountEmail: Text(
                currentUser?.email ?? 'EAA • Air Traffic Control Trainee',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color(0xFF3D52D5),
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
            ),
            _drawerItem(0, 'Dashboard', Icons.dashboard_rounded, drawerTextColor),
            _drawerItem(1, 'ICAO Courses', Icons.menu_book_rounded, drawerTextColor),
            _drawerItem(2, 'AI Tutor & Chat', Icons.psychology_rounded, drawerTextColor),
            _drawerItem(3, 'Trainee Progress & Metrics', Icons.analytics_rounded, drawerTextColor),
            _drawerItem(4, 'Student Profile', Icons.person_rounded, drawerTextColor),
            Divider(color: isDarkMode ? Colors.white24 : Colors.black12),
            _drawerItem(5, 'Settings', Icons.settings_rounded, drawerTextColor),
          ],
        ),
      ),
      body: _screens[_currentIndex],
    );
  }

  Widget _drawerItem(int index, String title, IconData icon, Color textColor) {
    final isSelected = _currentIndex == index;
    const accentColor = Color(0xFF3D52D5);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? accentColor : textColor.withOpacity(0.6),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? accentColor : textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: accentColor.withOpacity(0.12),
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
    );
  }
}