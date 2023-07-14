import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

late List d_;

class AllMentorBlockers extends ConsumerStatefulWidget {
  const AllMentorBlockers({super.key});

  @override
  ConsumerState<AllMentorBlockers> createState() => _AllMentorBlockersState();
}

class _AllMentorBlockersState extends ConsumerState<AllMentorBlockers> {
  Color tappedTextColor = const Color(0xFFFFFFFF);
  Color unTappedTextColor = const Color(0xFF504D51);
  int currentlyTapped = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.h),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24.sp,
            ),
          ),
          title: Text(
            'Blockers',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 6.h,
          ),
          Card(
            child: Container(
              height: 60.h,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  BlockerCards(
                    text: 'All',
                    textColor: currentlyTapped == 0
                        ? tappedTextColor
                        : unTappedTextColor,
                    boxColor: currentlyTapped == 0
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                    border: currentlyTapped == 0
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 0;
                      });
                    },
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  BlockerCards(
                    text: 'Pending',
                    textColor: currentlyTapped == 1
                        ? tappedTextColor
                        : unTappedTextColor,
                    boxColor: currentlyTapped == 1
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                    border: currentlyTapped == 1
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 1;
                      });
                    },
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  BlockerCards(
                    text: 'Resolved',
                    textColor: currentlyTapped == 2
                        ? tappedTextColor
                        : unTappedTextColor,
                    border: currentlyTapped == 2
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 2;
                      });
                    },
                    boxColor: currentlyTapped == 2
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Expanded(
            child: currentlyTapped == 0
                ? const AllBlockers()
                : currentlyTapped == 1
                    ? const Pending()
                    : const Resolved(),
          )
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
