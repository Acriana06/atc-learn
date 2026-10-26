import 'package:flutter/material.dart';
import '../../services/app_state.dart';
import '../../services/local_curriculum_repository.dart';
import '../modules/module_detail_screen.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({Key? key}) : super(key: key);

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  List<CourseContent> _courses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    const repository = LocalCurriculumRepository();
    setState(() {
      _courses = repository.getAllCourses();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _courses.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
              SizedBox(height: 16),
              Text(
                'No local courses found.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _courses.length,
        itemBuilder: (context, i) {
          final course = _courses[i];
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
                course.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  course.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D52D5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  AppStateManager.instance.startCourse(course.id);

                  // Grab the first module ID of this course to display initially
                  final firstModuleId = course.modules.isNotEmpty ? course.modules.first.id : '';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModuleDetailScreen(
                        courseId: course.id,
                        moduleId: firstModuleId,
                      ),
                    ),
                  );
                },
                child: const Text('Start', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}