import '../services/local_curriculum_repository.dart';

class CourseProvider with ChangeNotifier {
  List<CourseContent> _courses = [];
  bool _isLoading = false;

  List<CourseContent> get courses => _courses;
  bool get isLoading => _isLoading;

  void loadCourses() {
    _isLoading = true;
    notifyListeners();

    // Pulls all 9 courses instantly from local memory (zero database limits!)
    _courses = LocalCurriculumRepository.getAllCourses();

    _isLoading = false;
    notifyListeners();
  }
}