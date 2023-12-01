import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../extras/api/report_api.dart';
import '../../../../extras/components/files.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return PreferredSize(
      preferredSize: Size.fromHeight(44.h),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Weekly Report',
            style: GoogleFonts.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF423B43),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CircularPercentIndicator(
                radius: 13.r,
                lineWidth: 3.0,
                percent: 0.3,
                backgroundColor: Colors.grey,
                progressColor: AppTheme.kPurpleColor,
                circularStrokeCap: CircularStrokeCap.round,
                animationDuration: 500,
                reverse: true,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 32.h,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question1,
                    style: GoogleFonts.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'type something...',
                      hintStyle: GoogleFonts.raleway(
                        color: AppTheme.kHintTextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    maxLines: 12,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Answer cannot be empty';
                      }
                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          AppNavigator.pop();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.raleway(
                            color: AppTheme.kPurpleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 350.h,
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          DecodedTokenResponse? decodedToken =
                              await SecureStorageUtils
                                  .getTokenResponseFromStorage(
                                      SharedPrefKeys.tokenResponse);
                          if (formKey.currentState!.validate()) {
                            weeklyReport['student_id'] = decodedToken!.userId;
                            weeklyReport['question_1'] = textController.text;
                            AppNavigator.navigateTo(reportRoute1);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.raleway(
                                color: AppTheme.kPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.kPurpleColor,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportPage1 extends StatelessWidget {
  const ReportPage1({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return PreferredSize(
      preferredSize: appBarHeight,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Weekly Report',
            style: GoogleFonts.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF423B43),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CircularPercentIndicator(
                radius: 13.r,
                lineWidth: 3.0,
                percent: 0.7,
                backgroundColor: Colors.grey,
                progressColor: AppTheme.kPurpleColor,
                circularStrokeCap: CircularStrokeCap.round,
                animationDuration: 500,
                reverse: true,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    question2,
                    style: GoogleFonts.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'type something...',
                      hintStyle: GoogleFonts.raleway(
                        color: AppTheme.kHintTextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    maxLines: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          AppNavigator.doPop();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.raleway(
                            color: AppTheme.kPurpleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 350.h,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            weeklyReport['question_2'] = textController.text;
                            AppNavigator.navigateTo(reportRoute2);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.raleway(
                                color: AppTheme.kPurpleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.kPurpleColor,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final isTappedProvider = StateProvider<bool>((ref) {
  return false;
});

class ReportPage2 extends ConsumerWidget {
  const ReportPage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return PreferredSize(
      preferredSize: appBarHeight,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Weekly Report',
            style: GoogleFonts.raleway(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF423B43),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CircularPercentIndicator(
                radius: 13.r,
                lineWidth: 3.0,
                percent: 1.0,
                backgroundColor: Colors.grey,
                progressColor: AppTheme.kPurpleColor,
                circularStrokeCap: CircularStrokeCap.round,
                reverse: true,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question3,
                    style: GoogleFonts.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return TextField(
                        controller: controller,
                        onChanged: (value) {
                          ref.read(isTappedProvider.notifier).state = true;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type something...',
                          hintStyle: GoogleFonts.raleway(
                            color: AppTheme.kHintTextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        maxLines: 12,
                      );
                    },
                  ),
                  SizedBox(
                    height: 280.h,
                  ),
                  CustomButton(
                    height: 54.h,
                    pressed: () {
                      if (formKey.currentState!.validate()) {
                        weeklyReport['question_3'] = controller.text;
                        if (kDebugMode) {
                          print(weeklyReport);
                        }

                        popUp(context);
                      }
                    },
                    color: ref.read(isTappedProvider) == false
                        ? const Color(0xFF96599A)
                        : AppTheme.kPurpleColor,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(8.r),
                    elevation: 0,
                    child: Text(
                      'Submit Report',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> popUp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Report Submission',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF383639),
          ),
        ),
        content: Text(
          'Are you sure you want to proceed with the report?',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  AppNavigator.doPop();
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kPurpleColor,
                  ),
                ),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomButton(
                    height: 54.h,
                    pressed: () {
                      ref.read(apiReportProvider).submitReport(weeklyReport);
                      AppNavigator.pop();
                      popUp1(context);
                    },
                    color: AppTheme.kPurpleColor,
                    width: 137.5.w,
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8.r),
                    child: Text(
                      'Yes!, Submit',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> popUp1(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Report Submission',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF383639),
          ),
        ),
        content: Text(
          'Well-done, report sent',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          CustomButton(
            height: 54.h,
            pressed: () {
              AppNavigator.navigateTo(homeRoute);
            },
            color: AppTheme.kPurpleColor,
            width: 307.w,
            elevation: 0,
            borderRadius: BorderRadius.circular(8.r),
            child: Text(
              'Ok!',
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
              ),
            ),
          )
        ],
      );
    },
  );
}
