import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/aspirant_model.dart';
import 'mentor_slip.dart';

class CardContent extends ConsumerStatefulWidget {
  const CardContent(
      {required this.numberEnrolled,
      required this.contentDuration,
      required this.trackName,
      required this.mentorName,
      required this.d,
      super.key});

  final int numberEnrolled;
  final int contentDuration;
  final String trackName;
  final String mentorName;
  final AspirantModelClass d;

  @override
  ConsumerState<CardContent> createState() => _CardContentState();
}

class _CardContentState extends ConsumerState<CardContent> {
  double progress = d.progress!.toDouble() / 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 16.w,
      ),
      width: 343.w,
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
                  'Cohort duration: ${widget.contentDuration} month(s)',
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: kSmallTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 16.w),
            height: 55.h,
            child: Text(
              widget.trackName,
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
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              'Mentor',
              style: kSmallTextStyle2,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MentorSlip(
                  mentorName: widget.mentorName,
                  profileUrl: d.mentor!.profilePicture!,
                ),
                Text(
                  '${widget.numberEnrolled} Enrolled',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomButton(
              elevation: 0,
              height: 44.h,
              pressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TrackDetails(d: d);
                }));
              },
              color: const Color(0xFFB58BB8),
              width: double.infinity,
              borderRadius: BorderRadius.circular(6.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'See all Courses',
                    style: GoogleFonts.raleway(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.kAppWhiteScheme,
                    ),
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/see_all_courses.png',
                      color: AppTheme.kAppWhiteScheme,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
            color: Color(0xFFCBADCD),
          ),
          SizedBox(
            height: 16.h,
          ),
          LinearPercentIndicator(
            addAutomaticKeepAlive: true,
            width: 340.w,
            lineHeight: 4.h,
            percent: progress,
            backgroundColor: const Color(0xFFCBADCD),
            progressColor: const Color(0xFF2BBDB2),
            barRadius: Radius.circular(24.r),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${progress * 100}% completion',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
