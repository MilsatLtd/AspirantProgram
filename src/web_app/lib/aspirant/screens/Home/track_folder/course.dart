import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Home/track_folder/course_model.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CourseDetails extends StatelessWidget {
  static const String name = 'courseDetails';
  static const String route = '/courseDetails';
  const CourseDetails({
    super.key,
    required this.courseDemoModel,
  });

  final CourseDemoModel courseDemoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          44,
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            'Course',
            style: kCourseTextStyle,
          ),
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseDemoModel.courseTitle,
              style: kOnboardingLightTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              courseDemoModel.courseDescription,
              style: GoogleFonts.raleway(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              courseDemoModel.courseRequirementTitle,
              style: kOnboardingLightTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              courseDemoModel.courseRequirement,
              style: GoogleFonts.raleway(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SubmitToDoPage(
                          courseId: courseDemoModel.courseId,
                        );
                      }),
                    );
                  },
                  child: Container(
                    width: 145,
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFCBADCD),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Submit To-do\'s',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF504D51),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  height: 42,
                  pressed: courseDemoModel.pressed,
                  color: AppTheme.kPurpleColor,
                  width: 145,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Text(
                        'Take Course',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        'assets/take_course_arrow.svg',
                        height: 10.2,
                        width: 10.2,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
