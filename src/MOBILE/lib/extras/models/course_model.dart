class CourseModel {
  String? trackId;
  String? name;
  String? description;
  List<Course>? courses;

  CourseModel({
    this.trackId,
    this.name,
    this.description,
    this.courses,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        trackId: json["track_id"],
        name: json["name"],
        description: json["description"],
        courses: json["courses"] == null
            ? []
            : List<Course>.from(
                json["courses"]!.map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "track_id": trackId,
        "name": name,
        "description": description,
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

class Course {
  String? courseId;
  String? name;
  String? description;
  String? requirements;
  String? accessLink;
  int? order;
  bool? canView;
  Todo? todo;

  Course({
    this.courseId,
    this.name,
    this.description,
    this.requirements,
    this.accessLink,
    this.order,
    this.canView,
    this.todo,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseId: json["course_id"],
        name: json["name"],
        description: json["description"],
        requirements: json["requirements"],
        accessLink: json["access_link"],
        order: json["order"],
        canView: json["can_view"],
        todo: json["todo"] == null ? null : Todo.fromJson(json["todo"]),
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "name": name,
        "description": description,
        "requirements": requirements,
        "access_link": accessLink,
        "order": order,
        "can_view": canView,
        "todo": todo?.toJson(),
      };
}

class Todo {
  String? todoId;
  String? summary;
  String? course;
  int? status;
  String? student;
  dynamic feedback;
  String? document;

  Todo({
    this.todoId,
    this.summary,
    this.course,
    this.status,
    this.student,
    this.feedback,
    this.document,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        todoId: json["todo_id"],
        summary: json["summary"],
        course: json["course"],
        status: json["status"],
        student: json["student"],
        feedback: json["feedback"],
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
        "todo_id": todoId,
        "summary": summary,
        "course": course,
        "status": status,
        "student": student,
        "feedback": feedback,
        "document": document,
      };
}
