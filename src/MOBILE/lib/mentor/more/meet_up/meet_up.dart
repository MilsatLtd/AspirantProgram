// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

List<ScheduleStructure> schedules = [];

class MeetUpScreen extends StatelessWidget {
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Create your first meetup.',
            style: GoogleFonts.raleway(
              color: const Color(0xFF383639),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.navigateTo(scheduleMeetUpRoute);
            },
            child: Container(
              width: 88.w,
              height: 32.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9A989A),
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/add_button.svg',
                    color: AppTheme.kPurpleColor,
                    height: 15.h,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Create',
                    style: GoogleFonts.raleway(
                      color: AppTheme.kPurpleColor,
                      fontSize: 14.sp,
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
        preferredSize: Size.fromHeight(44.h),
        child: AppBar(
          title: Text(
            'Meetup',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          actions: [
            GestureDetector(
              onTap: () {
                AppNavigator.navigateTo(scheduleMeetUpRoute);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: 20.w,
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
                AppNavigator.pop();
              }
              AppNavigator.navigateTo(mentorSkeletonRoute);
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
              padding: EdgeInsets.only(
                top: 16.h,
                left: 16.w,
                right: 16.w,
              ),
              itemBuilder: (context, index) {
                return schedules[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 24.h,
                );
              },
              itemCount: schedules.length,
            ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
