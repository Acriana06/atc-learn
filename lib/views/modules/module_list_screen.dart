import 'package:flutter/material.dart';
import '../../services/app_state.dart';
import '../modules/module_detail_screen.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({Key? key}) : super(key: key);

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    await AppStateManager.instance.fetchCoursesFromSupabase();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICAO Training Modules'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListenableBuilder(
        listenable: AppStateManager.instance,
        builder: (context, child) {
          final courses = AppStateManager.instance.allCourses;

          if (courses.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
                    SizedBox(height: 16),
                    Text(
                      'No courses found in Supabase.\nPlease check your database table and RLS policies.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, i) {
              final course = courses[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF3D52D5),
                    child: Icon(Icons.menu_book, color: Colors.white, size: 18),
                  ),
                  title: Text(
                    course['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      'Code: ${course['code']} | Status: ${course['status'] ?? 'Not Started'}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D52D5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      AppStateManager.instance.startCourse(course['id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ModuleDetailScreen(courseData: course),
                        ),
                      );
                    },
                    child: const Text('Start', style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}