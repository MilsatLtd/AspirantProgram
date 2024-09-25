// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/mentor/more/meet_up/schedule_meetup.dart';

List<ScheduleStructure> schedules = [];

class MeetUpScreen extends StatelessWidget {
  static const String name = 'meet-up';
  static const String route = '/meet-up';
  const MeetUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget createSchedule = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No meetup\'s yet!',
            style: GoogleFonts.raleway(
              color: const Color(0xFF383639),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Create your first meetup.',
            style: GoogleFonts.raleway(
              color: const Color(0xFF383639),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              context.push(ScheduleMeetUp.route);
            },
            child: Container(
              width: 88,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9A989A),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/add_button.svg',
                    color: AppTheme.kPurpleColor,
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Create',
                    style: GoogleFonts.raleway(
                      color: AppTheme.kPurpleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (kDebugMode) {
      print(schedules.isEmpty);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          title: Text(
            'Meetup',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          actions: [
            GestureDetector(
              onTap: () {
                context.push(ScheduleMeetUp.route);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: SvgPicture.asset(
                  'assets/add_button.svg',
                ),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              if (schedules.isEmpty) {
                context.pop();
              }
              context.push(MentorPageSkeleton.route);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: schedules.isEmpty
          ? createSchedule
          : ListView.separated(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              itemBuilder: (context, index) {
                return schedules[index];
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 24,
                );
              },
              itemCount: schedules.length,
            ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
