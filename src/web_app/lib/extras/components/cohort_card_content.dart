import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/aspirant_model.dart';
import 'mentor_slip.dart';

class CardContent extends ConsumerWidget {
  const CardContent(
      {this.numberEnrolled,
      this.contentDuration,
      this.trackName,
      this.mentorName,
      required this.d,
      super.key});

  final int? numberEnrolled;
  final int? contentDuration;
  final String? trackName;
  final String? mentorName;
  final AspirantModelClass d;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double progress = d.progress!.toDouble() / 100;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      width: width * 0.885,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ongoing Track:',
                      style: kSmallTextStyle,
                    ),
                    contentDuration == 1
                        ? Text(
                            'Cohort duration: $contentDuration week',
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: kSmallTextStyle,
                          )
                        : Text(
                            'Cohort duration: $contentDuration weeks',
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: kSmallTextStyle,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01491,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: MediaQuery.of(context).size.height * 0.068,
                child: Text(
                  trackName!,
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.75,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0199,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Mentor',
                  style: kSmallTextStyle2,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MentorSlip(
                      mentorName: mentorName!,
                      profileUrl: d.mentor?.profilePicture,
                      onTap: null,
                    ),
                    Text(
                      '$numberEnrolled Enrolled',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0398,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  elevation: 0,
                  height: 44,
                  pressed: () {
                    context.push(TrackDetails.route, extra: d);
                  },
                  color: const Color(0xFFB58BB8),
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'See all Courses',
                        style: GoogleFonts.raleway(
                          fontSize: 13,
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
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: Color(0xFFCBADCD),
              ),
              const SizedBox(
                height: 16,
              ),
              LinearPercentIndicator(
                addAutomaticKeepAlive: true,
                width: width / 1.2,
                lineHeight: 4,
                percent: progress,
                backgroundColor: const Color(0xFFCBADCD),
                progressColor: const Color(0xFF2BBDB2),
                barRadius: const Radius.circular(24),
                alignment: MainAxisAlignment.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 14.5, right: 14.5, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(1)}% completion',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
