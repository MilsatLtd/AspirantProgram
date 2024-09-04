// class ReportList {
//   List<AspirantReport>? report;

//   ReportList({
//     this.report,
//   });

//   ReportList.fromJson(List<Map<String, dynamic>> json) {
//     report = json.isEmpty
//         ? <AspirantReport>[]
//         : List<AspirantReport>.from(
//             json.map((x) => AspirantReport.fromJson(x)));
//   }
// }

class AspirantReport {
  String? studentId;
  String? question1;
  String? question2;
  String? question3;
  String? fullName;
  String? profilePicture;
  String? reportId;
  int? age;
  dynamic mentorFeedback;

  AspirantReport({
    this.studentId,
    this.question1,
    this.question2,
    this.question3,
    this.fullName,
    this.profilePicture,
    this.reportId,
    this.age,
    this.mentorFeedback,
  });

  AspirantReport.fromJson(Map<String, dynamic> json) {
    studentId = json["student_id"];
    question1 = json["question_1"];
    question2 = json["question_2"];
    question3 = json["question_3"];
    fullName = json["full_name"];
    profilePicture = json["profile_picture"];
    reportId = json["report_id"];
    age = json["age"];
    mentorFeedback = json["mentor_feedback"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["student_id"] = studentId;
    data["question_1"] = question1;
    data["question_2"] = question2;
    data["question_3"] = question3;
    data["full_name"] = fullName;
    data["profile_picture"] = profilePicture;
    data["report_id"] = reportId;
    data["age"] = age;
    data["mentor_feedback"] = mentorFeedback;
    return data;
  }
}
