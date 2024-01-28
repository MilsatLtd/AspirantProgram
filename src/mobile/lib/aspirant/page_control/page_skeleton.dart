// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../extras/components/files.dart';

class PageSkeleton extends StatefulWidget {
  const PageSkeleton({super.key});

  @override
  State<PageSkeleton> createState() => _PageSkeletonState();
}

class _PageSkeletonState extends State<PageSkeleton> {
  final pages = List.unmodifiable(const [
    HomeScreen(),
    ForumScreen(),
    ProfileScreen(),
  ]);

  int currentIndex = 0;
  bool tapped = false;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      tapped = !tapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [...pages],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedLabelStyle: GoogleFonts.raleway(
          fontSize: 14,
          color: AppTheme.kPurpleColor2,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home_icon.svg',
              color: currentIndex == 0
                  ? AppTheme.kPurpleColor2
                  : AppTheme.kLightPurpleColor,
              height: 16,
              width: 16,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/chat_icon.svg',
              color: currentIndex == 1
                  ? AppTheme.kPurpleColor2
                  : AppTheme.kLightPurpleColor,
              height: 16,
              width: 16,
            ),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile_icon.svg',
              color: currentIndex == 2
                  ? AppTheme.kPurpleColor2
                  : AppTheme.kLightPurpleColor,
              height: 16,
              width: 16,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
