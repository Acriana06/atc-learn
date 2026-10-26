class CourseContent {
  final int courseNumber;
  final String title;
  final String code;
  final String category;
  final String overview;
  final List<String> learningObjectives;
  final String fullContent;

  const CourseContent({
    required this.courseNumber,
    required this.title,
    required this.code,
    required this.category,
    required this.overview,
    required this.learningObjectives,
    required this.fullContent,
  });
}