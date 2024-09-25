// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/mentor/more/blocker/all_blockers_mentor.dart';

import '../extras/components/files.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  bool firstTapped = false;
  bool secondTapped = false;
  bool thirdTapped = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF2EBF3),
        ),
        color: AppTheme.kAppWhiteScheme,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomButtonNavBarItem(
              image: SvgPicture.asset(
                'assets/home_icon.svg',
                color: firstTapped == true
                    ? AppTheme.kPurpleColor2
                    : const Color(0xFF504D51),
                height: 16,
                width: 16,
              ),
              label: 'Home',
              onPressed: () {
                setState(() {
                  firstTapped = true;
                  secondTapped = false;
                  thirdTapped = false;
                });
                context.push(MentorPageSkeleton.route);
              },
              textColor: firstTapped == true
                  ? AppTheme.kPurpleColor2
                  : const Color(0xFF504D51),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomButtonNavBarItem(
              image: SvgPicture.asset(
                'assets/profile_icon.svg',
                color: secondTapped == true
                    ? AppTheme.kPurpleColor2
                    : const Color(0xFF504D51),
                height: 16,
                width: 16,
              ),
              label: 'Profile',
              onPressed: () {
                setState(() {
                  firstTapped = false;
                  secondTapped = true;
                  thirdTapped = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MentorPageSkeleton(
                      currentPage: 1,
                    );
                  }),
                );
              },
              textColor: secondTapped == true
                  ? AppTheme.kPurpleColor2
                  : const Color(0xFF504D51),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                firstTapped = false;
                secondTapped = false;
                thirdTapped = true;
              });
              showModalBottomSheet(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      height: 256,
                      color: AppTheme.kAppWhiteScheme,
                      child: Column(
                        children: [
                          Container(
                            height: 4,
                            width: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppTheme.kHintTextColor,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          MorePages(
                            image: 'assets/blocker_icon.svg',
                            onTap: () {
                              context.go(AllMentorBlockers.route);
                            },
                            pageName: 'Blockers',
                            pageDescription: 'View and respond to all blockers',
                            width: 19,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          MorePages(
                            image: 'assets/report_icon.svg',
                            onTap: () {
                              context.go(ReportPageMentor.route);
                            },
                            pageName: 'Report',
                            pageDescription: 'View mentee weekly report',
                            width: 19,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          MorePages(
                            image: 'assets/meet_svg.svg',
                            onTap: () {
                              context.go(MeetUpScreen.route);
                            },
                            pageName: 'Meetup',
                            pageDescription: 'Schedule meeting with mentee',
                            width: 17,
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Column(
              children: [
                Icon(
                  Icons.more_horiz,
                  color: thirdTapped
                      ? AppTheme.kPurpleColor2
                      : const Color(0xFF504D51),
                ),
                Text(
                  'More',
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    color: thirdTapped
                        ? AppTheme.kPurpleColor2
                        : const Color(0xFF504D51),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
