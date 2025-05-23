import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../extras/api/report_api.dart';
import '../../../extras/components/files.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return PreferredSize(
      preferredSize: const Size.fromHeight(44),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Weekly Report',
            style: GoogleFonts.raleway(
              fontSize: 16,
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
              padding: const EdgeInsets.only(right: 16),
              child: CircularPercentIndicator(
                radius: 13,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question1,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'type something...',
                      hintStyle: GoogleFonts.raleway(
                        color: AppTheme.kHintTextColor,
                        fontSize: 14,
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
                      const SizedBox(
                        height: 350,
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          DecodedTokenResponse? decodedToken =
                              await SecureStorageUtils.getDataFromStorage<
                                      DecodedTokenResponse>(
                                  SharedPrefKeys.tokenResponse,
                                  DecodedTokenResponse.fromJsonString);
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.kPurpleColor,
                              size: 14,
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
              fontSize: 16,
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
              padding: const EdgeInsets.only(right: 16),
              child: CircularPercentIndicator(
                radius: 13,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Something...',
                      hintStyle: GoogleFonts.raleway(
                        color: AppTheme.kHintTextColor,
                        fontSize: 14,
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
                      const SizedBox(
                        height: 350,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.kPurpleColor,
                              size: 14,
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

class ReportPage2 extends ConsumerStatefulWidget {
  const ReportPage2({super.key});

  @override
  ConsumerState<ReportPage2> createState() => _ReportPage2State();
}

class _ReportPage2State extends ConsumerState<ReportPage2> {
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEdited = false;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: appBarHeight,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Weekly Report',
            style: GoogleFonts.raleway(
              fontSize: 16,
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
              padding: const EdgeInsets.only(right: 16),
              child: CircularPercentIndicator(
                radius: 13,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question3,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF423B43),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return TextField(
                        controller: controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ref.read(isTappedProvider.notifier).state = true;
                            setState(() {
                              isEdited = true;
                            });
                          } else {
                            setState(() {
                              isEdited = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type Something...',
                          hintStyle: GoogleFonts.raleway(
                            color: AppTheme.kHintTextColor,
                            fontSize: 14,
                          ),
                        ),
                        maxLines: 12,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 280,
                  ),
                  CustomButton(
                    height: 54,
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
                    borderRadius: BorderRadius.circular(8),
                    elevation: 0,
                    child: Text(
                      'Submit Report',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kAppWhiteScheme,
                        fontSize: 14,
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF383639),
          ),
        ),
        content: Text(
          'Are you sure you want to proceed with the report?',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
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
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return CustomButton(
                      height: 54,
                      pressed: () {
                        ref.read(apiReportProvider).submitReport(weeklyReport);
                        AppNavigator.pop();
                        popUp1(context);
                      },
                      color: AppTheme.kPurpleColor,
                      width: 137.5,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(8),
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF383639),
          ),
        ),
        content: Text(
          'Well-done, report sent',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          CustomButton(
            height: 54,
            pressed: () {
              AppNavigator.navigateTo(homeRoute);
            },
            color: AppTheme.kPurpleColor,
            width: 307,
            elevation: 0,
            borderRadius: BorderRadius.circular(8),
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
