import 'package:milsat_project_app/extras/models/blocker_model.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

String question1 = 'What course did you take this week?';
String question2 = 'What did you learn during the course of the week?';
String question3 = 'How do you plan on applying what you learnt this week?';

Map<String, dynamic> cred = {};
Map<String, dynamic> personalInfo = {};
Map<String, dynamic> weeklyReport = {
  'student_id': '',
  'question_1': '',
  'question_2': '',
  'question_3': '',
};

List error = [];
List message = [];

DecodedTokenResponse? loginResponse;
List<BlockerCommentModel>? blockerReply;
