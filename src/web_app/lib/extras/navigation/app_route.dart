import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milsat_project_app/aspirant/screens/Home/track_folder/course_model.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';
import 'package:milsat_project_app/general/auth/forgot_password/input_token.dart';
import 'package:milsat_project_app/mentor/more/blocker/all_blockers_mentor.dart';
import 'package:milsat_project_app/mentor/more/meet_up/schedule_meetup.dart';
import 'package:milsat_project_app/mentor/profile/profile.dart';

import 'persistent_navigation_service.dart';

final routes = GoRouter(
  initialLocation: SplashScreen.route,
  observers: [CustomRouteObserver()],
  redirect: (context, state) async {
    if (kIsWeb) {
      final currentLocation = state.fullPath;
      final routeInfo = await NavigationService.getLastRouteInfo();
      final savedRoute = routeInfo['route'] as String?;

      // Check if we're at the initial route/splash screen
      if (savedRoute != null &&
          (currentLocation == SplashScreen.route || currentLocation == '/')) {
        // Make sure the saved route starts with '/'
        final redirectPath =
            savedRoute.startsWith('/') ? savedRoute : '/$savedRoute';

        return redirectPath;
      }

      // If we're not at splash screen, save the current route
      if (currentLocation != SplashScreen.route && currentLocation != '/') {
        await NavigationService.saveCurrentRoute(
          path: currentLocation!,
          extra: state.extra,
        );
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      name: SplashScreen.name,
      path: SplashScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      name: OnboardingScreen.name,
      path: OnboardingScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingScreen(),
    ),
    GoRoute(
      name: LoginScreen.name,
      path: LoginScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      name: ForgotPassword.name,
      path: ForgotPassword.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPassword(),
    ),
    GoRoute(
      name: MentorPageSkeleton.name,
      path: MentorPageSkeleton.route,
      builder: (BuildContext context, GoRouterState state) =>
          MentorPageSkeleton(
        currentPage: state.extra != null
            ? (state.extra as Map<String, dynamic>)["currentPage"] ?? 0
            : 0,
      ),
    ),
    GoRoute(
      name: AddBlocker.name,
      path: AddBlocker.route,
      builder: (BuildContext context, GoRouterState state) =>
          const AddBlocker(),
    ),
    GoRoute(
      name: AllBlockers.name,
      path: AllBlockers.route,
      builder: (BuildContext context, GoRouterState state) =>
          const AllBlockers(),
    ),
    GoRoute(
      name: CheckEmailScreen.name,
      path: CheckEmailScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const CheckEmailScreen(),
    ),
    GoRoute(
      name: PasswordPage.name,
      path: PasswordPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const PasswordPage(),
    ),
    GoRoute(
      name: EditProfile.name,
      path: EditProfile.route,
      builder: (BuildContext context, GoRouterState state) =>
          const EditProfile(),
    ),
    GoRoute(
      name: BlockerPage.name,
      path: BlockerPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const BlockerPage(),
    ),
    GoRoute(
      name: ReportPage.name,
      path: ReportPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ReportPage(),
    ),
    GoRoute(
      name: ReportPage1.name,
      path: ReportPage1.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ReportPage1(),
    ),
    GoRoute(
      name: ReportPage2.name,
      path: ReportPage2.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ReportPage2(),
    ),
    GoRoute(
      name: MentorPasswordPage.name,
      path: MentorPasswordPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const MentorPasswordPage(),
    ),
    GoRoute(
      name: MentorProfilePage.name,
      path: MentorProfilePage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const MentorProfilePage(),
    ),
    GoRoute(
      name: EditMentorProfile.name,
      path: EditMentorProfile.route,
      builder: (BuildContext context, GoRouterState state) =>
          const EditMentorProfile(),
    ),
    GoRoute(
      name: ViewAllPage.name,
      path: ViewAllPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ViewAllPage(),
    ),
    GoRoute(
      name: MeetUpScreen.name,
      path: MeetUpScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const MeetUpScreen(),
    ),
    GoRoute(
      name: ScheduleMeetUp.name,
      path: ScheduleMeetUp.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ScheduleMeetUp(),
    ),
    GoRoute(
      name: ReportPageMentor.name,
      path: ReportPageMentor.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ReportPageMentor(),
    ),
    GoRoute(
      name: AllMentorBlockers.name,
      path: AllMentorBlockers.route,
      builder: (BuildContext context, GoRouterState state) =>
          const AllMentorBlockers(),
    ),
    GoRoute(
      name: InputTokenPage.name,
      path: InputTokenPage.route,
      builder: (BuildContext context, GoRouterState state) =>
          const InputTokenPage(),
    ),
    GoRoute(
      name: ProfileScreen.name,
      path: ProfileScreen.route,
      builder: (BuildContext context, GoRouterState state) =>
          const ProfileScreen(),
    ),
    GoRoute(
      name: TrackDetails.name,
      path: TrackDetails.route,
      builder: (BuildContext context, GoRouterState state) => TrackDetails(
        d: state.extra as AspirantModelClass,
      ),
    ),
    GoRoute(
      name: CourseDetails.name,
      path: CourseDetails.route,
      builder: (BuildContext context, GoRouterState state) {
        return CourseDetails(
          courseDemoModel: state.extra as CourseDemoModel,
        );
      },
    ),
  ],
);
