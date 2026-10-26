import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppStateManager extends ChangeNotifier {
  static final AppStateManager instance = AppStateManager._internal();
  AppStateManager._internal();

  // Dynamic Trainee Profile Data (Synced with Supabase User)
  String cadetName = 'ATC Trainee';
  String cadetEmail = 'trainee@eaa.edu.et';
  String cadetPhone = '+251 91 000 0000';
  String cadetId = 'EAA-ATC-0248';

  // Dynamic Dashboard Metrics
  int completedCoursesCount = 0;
  double overallPassRate = 0.0;
  int totalStudySeconds = 0; // Track seconds for high precision

  double get totalStudyHours => totalStudySeconds / 3600.0;

  int _quizAttempts = 0;
  int _totalQuizScoreSum = 0;

  // Real ICAO & EAA Course Curriculum (Fetched from Supabase with fallback)
  List<Map<String, dynamic>> allCourses = [];

  /// Fetch all official ICAO courses directly from Supabase (with built-in fallback)
  Future<void> fetchCoursesFromSupabase() async {
    try {
      final response = await Supabase.instance.client
          .from('courses')
          .select()
          .order('course_number', ascending: true);

      if (response != null && (response as List).isNotEmpty) {
        allCourses = List<Map<String, dynamic>>.from(response).map((c) => {
          'id': c['id'].toString(),
          'course_number': c['course_number'] ?? 1,
          'title': c['title'] ?? '',
          'code': c['code'] ?? '',
          'category': c['category'] ?? '',
          'description': c['description'] ?? '',
          'full_content': c['full_content'] ?? '',
          'status': 'Not Started',
          'progress': 0.0,
        }).toList();

        notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint('Error fetching courses from Supabase: $e');
    }

    // FALLBACK: If Supabase table is empty or offline, load local default courses so UI works instantly!
    allCourses = [
      {
        'id': '1',
        'course_number': 1,
        'title': 'Air Law & Operational Regulations',
        'code': '010',
        'category': 'Regulatory Framework',
        'description': 'Covers international aviation treaties, regulatory authorities, safety mandates, and operational compliance standards for controllers.',
        'full_content': '# Air Law & Operational Regulations\n\n## 1. Regulatory Framework\nAir navigation services operate within unified international standards. General rules prioritize traffic management efficiency, airspace classification, and safety assurance across flight operational regions.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '2',
        'course_number': 2,
        'title': 'Aircraft General Knowledge & Principles of Flight',
        'code': '020',
        'category': 'Aeronautical Science',
        'description': 'Explores aerodynamics, aircraft systems, performance limitations, and wake turbulence categories affecting separation.',
        'full_content': '# Aircraft General Knowledge\n\n## 1. Aerodynamics & Performance\nUnderstanding lift, drag, and thrust configurations enables controllers to anticipate speed profiles during departure and approach phases.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '3',
        'course_number': 3,
        'title': 'Human Performance & Operational Psychology',
        'code': '030',
        'category': 'Human Factors',
        'description': 'Focuses on situational awareness, fatigue management, decision-making under stress, and effective teamwork in control environments.',
        'full_content': '# Human Performance\n\n## 1. Situational Awareness\nMaintaining an accurate mental model of current and projected traffic configurations is critical to avoiding tactical conflicts.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '4',
        'course_number': 4,
        'title': 'Aeronautical Meteorology',
        'code': '040',
        'category': 'Atmospheric Science',
        'description': 'Details hazardous weather phenomena, cloud formations, METAR/TAF interpretation, and severe weather avoidance protocols.',
        'full_content': '# Aeronautical Meteorology\n\n## 1. Weather Reports & Forecasts\nControllers monitor routine aerodrome reports (METAR) and terminal forecasts (TAF) to anticipate runway transitions.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '5',
        'course_number': 5,
        'title': 'Aeronautical Navigation & Charting',
        'code': '050',
        'category': 'Navigation Systems',
        'description': 'Covers PBN (Performance-Based Navigation), GNSS procedures, SID/STAR charting, and radio navigation aids.',
        'full_content': '# Air Navigation\n\n## 1. Performance-Based Navigation (PBN)\nPBN defines navigation specifications based on RNAV and RNP capabilities.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '6',
        'course_number': 6,
        'title': 'Standard Phraseology & Voice Communications',
        'code': '055',
        'category': 'Radiotelephony',
        'description': 'Focuses on radiotelephony standards, emergency phraseology, readback verification, and standard callouts.',
        'full_content': '# Standard Communications\n\n## 1. Radiotelephony Discipline\nTransmissions must be concise and unequivocal.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '7',
        'course_number': 7,
        'title': 'Aerodrome Control Procedures',
        'code': '070',
        'category': 'Tower Operations',
        'description': 'Covers visual control, runway separation minima, ground movements, and aerodrome surface safety.',
        'full_content': '# Aerodrome Control\n\n## 1. Surface Movement Guidance\nTower controllers regulate taxiway routing and runway crossings.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '8',
        'course_number': 8,
        'title': 'Approach Control Procedures',
        'code': '080',
        'category': 'Terminal Control',
        'description': 'Details arrival sequencing, procedural approach clearance, vectoring techniques, and holding stack entry rules.',
        'full_content': '# Approach Control\n\n## 1. Terminal Sequencing\nArrival managers organize incoming traffic into continuous descent profiles.',
        'status': 'Not Started',
        'progress': 0.0,
      },
      {
        'id': '9',
        'course_number': 9,
        'title': 'Area & Upper Airspace Control',
        'code': '090',
        'category': 'En-Route Control',
        'description': 'Explores high-altitude cruise separation, RVSM, sector coordination, and oceanic procedures.',
        'full_content': '# Area Control\n\n## 1. En-Route Separation\nControl centers maintain vertical and radar longitudinal intervals.',
        'status': 'Not Started',
        'progress': 0.0,
      },
    ];
    notifyListeners();
  }

  // Fetch current user details from Supabase Auth
  void loadUserData() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      cadetEmail = user.email ?? cadetEmail;
      cadetName = user.userMetadata?['full_name'] ?? cadetName;
      cadetPhone = user.userMetadata?['phone'] ?? cadetPhone;
      notifyListeners();
    }
  }

  // Update Profile Data
  void updateProfile({required String name, required String email, required String phone}) {
    cadetName = name;
    cadetEmail = email;
    cadetPhone = phone;
    notifyListeners();
  }

  // Start a course dynamically
  void startCourse(String courseId) {
    if (allCourses.isEmpty) return;
    final course = allCourses.firstWhere(
          (c) => c['id'] == courseId,
      orElse: () => {},
    );
    if (course.isNotEmpty && course['status'] == 'Not Started') {
      course['status'] = 'In Progress';
      course['progress'] = 0.25;
      notifyListeners();
    }
  }

  // Record elapsed study time from ModuleDetailScreen session
  void recordStudyTime(String courseId, int addedSeconds) async {
    totalStudySeconds += addedSeconds;

    final index = allCourses.indexWhere((c) => c['id'] == courseId);
    if (index != -1) {
      if (allCourses[index]['status'] == 'Not Started' || allCourses[index]['status'] == null) {
        allCourses[index]['status'] = 'In Progress';
      }
      if ((allCourses[index]['progress'] ?? 0.0) < 0.5) {
        allCourses[index]['progress'] = 0.5;
      }
    }

    notifyListeners();

    // Persist to Supabase if authenticated
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      try {
        await Supabase.instance.client.from('user_progress').upsert({
          'user_id': user.id,
          'course_id': courseId,
          'study_seconds': totalStudySeconds,
          'status': index != -1 ? allCourses[index]['status'] : 'In Progress',
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,course_id');
      } catch (e) {
        debugPrint('Error syncing study time to Supabase: $e');
      }
    }
  }

  // Record quiz score results from InteractiveQuizSheet
  void recordQuizResult(String courseId, int score, int totalQuestions) async {
    double scorePercentage = (score / totalQuestions) * 100.0;
    _quizAttempts++;
    _totalQuizScoreSum += scorePercentage.toInt();
    overallPassRate = _totalQuizScoreSum / _quizAttempts;

    final index = allCourses.indexWhere((c) => c['id'] == courseId);
    if (index != -1) {
      if (scorePercentage >= 70.0) {
        allCourses[index]['status'] = 'Completed';
        allCourses[index]['progress'] = 1.0;
      } else {
        allCourses[index]['status'] = 'In Progress';
        allCourses[index]['progress'] = 0.7;
      }
      completedCoursesCount = allCourses.where((c) => c['status'] == 'Completed').length;
    }

    notifyListeners();

    // Persist quiz results to Supabase
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null && index != -1) {
      try {
        await Supabase.instance.client.from('user_progress').upsert({
          'user_id': user.id,
          'course_id': courseId,
          'last_score': score,
          'completion_percentage': (allCourses[index]['progress'] * 100).toInt(),
          'status': allCourses[index]['status'],
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: 'user_id,course_id');
      } catch (e) {
        debugPrint('Error syncing quiz result to Supabase: $e');
      }
    }
  }

  // Legacy completeQuiz method wrapper for compatibility
  void completeQuiz(String courseId, double score) {
    recordQuizResult(courseId, (score * 10).toInt(), 10);
  }
}