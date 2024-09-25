class CourseDemoModel {
  final String courseTitle;
  final String courseDescription;
  final String courseRequirementTitle;
  final String courseRequirement;
  final Function() pressed;
  final String courseId;

  CourseDemoModel({
    required this.courseTitle,
    required this.courseDescription,
    required this.courseRequirementTitle,
    required this.courseRequirement,
    required this.pressed,
    required this.courseId,
  });
}
