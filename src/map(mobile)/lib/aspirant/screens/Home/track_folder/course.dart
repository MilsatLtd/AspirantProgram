import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({
    super.key,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseRequirementTitle,
    required this.courseRequirement,
    required this.pressed,
    required this.courseId,
  });

  final String courseTitle;
  final String courseDescription;
  final String courseRequirementTitle;
  final String courseRequirement;
  final Function() pressed;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          44.h,
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
              AppNavigator.doPop();
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
        padding: EdgeInsets.only(
          left: 16.w,
          top: 24.h,
          right: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseTitle,
              style: kOnboardingLightTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              courseDescription,
              style: GoogleFonts.raleway(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75.h,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              courseRequirementTitle,
              style: kOnboardingLightTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              courseRequirement,
              style: GoogleFonts.raleway(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75.h,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SubmitToDoPage(courseId: courseId);
                      }),
                    );
                  },
                  child: Container(
                    width: 145.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFCBADCD),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        'Submit To-do\'s',
                        style: GoogleFonts.raleway(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF504D51),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  height: 42.h,
                  pressed: pressed,
                  color: AppTheme.kPurpleColor,
                  width: 145.w,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Row(
                    children: [
                      Text(
                        'Take Course',
                        style: GoogleFonts.raleway(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      SvgPicture.asset(
                        'assets/take_course_arrow.svg',
                        height: 10.2.h,
                        width: 10.2.w,
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
