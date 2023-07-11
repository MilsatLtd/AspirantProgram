import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class MentorCardContent extends StatelessWidget {
  const MentorCardContent(
      {super.key,
      required this.count,
      required this.isLessThanOrEqualTo5,
      required this.cohortDuration,
      required this.trackName,
      required this.d});

  final int count;
  final bool isLessThanOrEqualTo5;
  final int cohortDuration;
  final String trackName;
  final MentorData d;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(count);
    }
    return Container(
      padding: EdgeInsets.only(
        top: 18.h,
        bottom: 16.w,
      ),
      height: 180.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ongoing Track:',
                  style: kSmallTextStyle,
                ),
                Text(
                  'Cohort duration: $cohortDuration months',
                  style: kSmallTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              trackName,
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                height: 1.75.h,
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AllAspirants(d: d);
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mentee\'s',
                    style: kSmallTextStyle2,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      InternSlip(
                        count: count,
                        d: d,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      if (isLessThanOrEqualTo5 == true)
                        const SizedBox.shrink()
                      else
                        Text(
                          '+${count - 5} more',
                          style: GoogleFonts.raleway(
                            color: const Color(0xFFF2EBF3),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
