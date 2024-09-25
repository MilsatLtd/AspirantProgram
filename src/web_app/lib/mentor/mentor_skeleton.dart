// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/general/log_out.dart';
import 'package:milsat_project_app/mentor/more/blocker/all_blockers_mentor.dart';
import 'package:milsat_project_app/mentor/profile/profile.dart';

import '../extras/components/files.dart';

class MentorPageSkeleton extends StatefulWidget {
  static const String name = 'mentor-skeleton';
  static const String route = '/mentor-skeleton';
  const MentorPageSkeleton({super.key, required this.currentPage});

  final int currentPage;

  @override
  State<MentorPageSkeleton> createState() => _MentorPageSkeletonState();
}

class _MentorPageSkeletonState extends State<MentorPageSkeleton> {
  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.currentPage;
    });
  }

  final pages = List.unmodifiable(
    const [
      MentorHomePage(),
      MentorProfilePage(),
    ],
  );

  int currentIndex = 0;
  bool firstTapped = false;
  bool secondTapped = false;
  bool moreTapped = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [...pages],
        ),
        bottomNavigationBar: Container(
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
                    color: firstTapped || widget.currentPage == 0
                        ? AppTheme.kPurpleColor2
                        : const Color(0xFF504D51),
                    height: 16,
                    width: 16,
                  ),
                  label: 'Home',
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                      firstTapped = true;
                      secondTapped = false;
                      moreTapped = false;
                    });
                  },
                  textColor: firstTapped || widget.currentPage == 0
                      ? AppTheme.kPurpleColor2
                      : const Color(0xFF504D51),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CustomButtonNavBarItem(
                  image: SvgPicture.asset(
                    'assets/profile_icon.svg',
                    color: secondTapped || widget.currentPage == 1
                        ? AppTheme.kPurpleColor2
                        : const Color(0xFF504D51),
                    height: 16,
                    width: 16,
                  ),
                  label: 'Profile',
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                      firstTapped = false;
                      secondTapped = true;
                      moreTapped = false;
                    });
                  },
                  textColor: secondTapped || widget.currentPage == 1
                      ? AppTheme.kPurpleColor2
                      : const Color(0xFF504D51),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    firstTapped = false;
                    secondTapped = false;
                    moreTapped = true;
                  });
                  showModalBottomSheet(
                      elevation: 1,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          decoration: const BoxDecoration(
                              color: AppTheme.kAppWhiteScheme,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              )),
                          height: 256,
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
                                  context.pop();
                                  context.go(AllMentorBlockers.route);
                                },
                                pageName: 'Blockers',
                                pageDescription:
                                    'View and respond to all blockers',
                                width: 19,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              MorePages(
                                image: 'assets/report_icon.svg',
                                onTap: () {
                                  context.pop();
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
                                  context.pop();
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
                      color: moreTapped
                          ? AppTheme.kPurpleColor2
                          : const Color(0xFF504D51),
                    ),
                    Text(
                      'More',
                      style: GoogleFonts.raleway(
                        fontSize: 13,
                        color: moreTapped
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
        ),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Do you want to sign out of the app?',
              style: GoogleFonts.raleway(
                color: const Color(0xFF423B43),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  'No',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kPurpleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  logOut(context);
                },
                child: Text(
                  'Yes',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kPurpleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        });
    return null;
  }
}
