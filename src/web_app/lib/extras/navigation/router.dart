import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milsat_project_app/general/auth/forgot_password/input_token.dart';
import 'package:milsat_project_app/mentor/more/blocker/all_blockers_mentor.dart';
import 'package:milsat_project_app/mentor/more/meet_up/schedule_meetup.dart';
import '../../mentor/profile/profile.dart';
import '../components/files.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case onboardRoute:
        return getPageRoute(
          settings: settings,
          view: const OnboardingScreen(),
        );
      case splashScreenRoute:
        return getPageRoute(
          settings: settings,
          view: const SplashScreen(),
        );
      case loginRoute:
        return getPageRoute(
          settings: settings,
          view: const LoginScreen(),
        );
      case forgotPasswordRoute:
        return getPageRoute(
          settings: settings,
          view: const ForgotPassword(),
        );
      case checkImageRoute:
        return getPageRoute(
          settings: settings,
          view: const CheckEmailScreen(),
        );
      case passwordRoute:
        return getPageRoute(
          settings: settings,
          view: const PasswordPage(),
        );
      case editProfileRoute:
        return getPageRoute(
          settings: settings,
          view: const EditProfile(),
        );
      case homeRoute:
        return getPageRoute(
          settings: settings,
          view: const HomeScreen(),
        );
      case mentorHomeRoute:
        return getPageRoute(
          settings: settings,
          view: const MentorHomePage(),
        );

      case blockerRoute:
        return getPageRoute(
          settings: settings,
          view: const BlockerPage(),
        );
      case reportRoute:
        return getPageRoute(
          settings: settings,
          view: const ReportPage(),
        );
      case reportRoute1:
        return getPageRoute(
          settings: settings,
          view: const ReportPage1(),
        );
      case reportRoute2:
        return getPageRoute(
          settings: settings,
          view: const ReportPage2(),
        );
      case raiseABlocker:
        return getPageRoute(
          settings: settings,
          view: const AddBlocker(),
        );
      case profileRoute:
        return getPageRoute(
          settings: settings,
          view: const ProfileScreen(),
        );
      case mentorSkeletonRoute:
        return getPageRoute(
          settings: settings,
          view: const MentorPageSkeleton(
            currentPage: 0,
          ),
        );
      case mentorPasswordRoute:
        return getPageRoute(
          settings: settings,
          view: const MentorPasswordPage(),
        );
      case mentorProfileRoute:
        return getPageRoute(
          settings: settings,
          view: const MentorProfilePage(),
        );
      case editMentorsProfileRoute:
        return getPageRoute(
          settings: settings,
          view: const EditMentorProfile(),
        );
      case viewAllRoute:
        return getPageRoute(
          settings: settings,
          view: const ViewAllPage(),
        );
      case meetUpRoute:
        return getPageRoute(
          settings: settings,
          view: const MeetUpScreen(),
        );
      case scheduleMeetUpRoute:
        return getPageRoute(
          settings: settings,
          view: const ScheduleMeetUp(),
        );
      case mentorReportRoute:
        return getPageRoute(
          settings: settings,
          view: const ReportPageMentor(),
        );
      case allMentorBlockertRoute:
        return getPageRoute(
          settings: settings,
          view: const AllMentorBlockers(),
        );
      case inputTokenPage:
        return getPageRoute(
          settings: settings,
          view: const InputTokenPage(),
        );

      default:
        return getPageRoute(
          settings: settings,
          view: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRoute<dynamic> getPageRoute({
    required RouteSettings settings,
    required Widget view,
  }) =>
      CupertinoPageRoute(settings: settings, builder: (_) => view);
}
