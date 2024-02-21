import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/report_api.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

final submittedReport = FutureProvider.autoDispose((ref) async {
  DecodedTokenResponse? response =
      await SecureStorageUtils.getDataFromStorage<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse, DecodedTokenResponse.fromJsonString);
  return ref
      .read(apiReportProvider)
      .getReportSubmmittedToMentor(response?.userId);
});

class ReportPageMentor extends ConsumerWidget {
  const ReportPageMentor({super.key});

  @override
  Widget build(BuildContext context, ref) {
    getTimeAgo<String>(index) {
      int time = cred['mentorReports'][index]['age'];
      double timeInHours = time / 60;
      if (timeInHours > 24 && timeInHours < 48) {
        return '1 day ${48 - 24} hours ago';
      } else if (timeInHours >= 48) {
        return '${timeInHours.floorToDouble()} hours ago';
      } else {
        return '$time minutes ago';
      }
    }

    final reports = ref.watch(submittedReport);

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await goToMentorHomePage();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: AppBar(
            backgroundColor: AppTheme.kAppWhiteScheme,
            elevation: 0.5,
            leading: IconButton(
              onPressed: () {
                AppNavigator.navigateTo(mentorSkeletonRoute);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Report',
              style: GoogleFonts.raleway(
                color: const Color(0xFF423B43),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: reports.when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'This Week',
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF504D51),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (cred['mentorReports'] == []) ...{
                    const Center(
                      child: Text('No submitted report yet'),
                    )
                  } else ...{
                    Expanded(
                      child: ListView.builder(
                        itemCount: cred['mentorReports'].length,
                        itemBuilder: ((context, index) {
                          if (kDebugMode) {
                            print(data.data[index]['age']);
                          }
                          int howLong = data.data[index]['age'];
                          // ignore: unused_local_variable
                          String howLongInText = 'This Week';
                          if (howLong > 10080 && howLong < 2 * 10080) {
                            howLongInText = 'Last Week';
                          } else if (howLong >= 2 * 10080) {
                            final value = howLong ~/ 10080;
                            if (kDebugMode) {
                              print(value);
                            }
                          }
                          return AspirantsTile(
                            image: cred['mentorReports'][index]
                                ['profile_picture'],
                            column: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cred['mentorReports'][index]
                                            ['full_name'],
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF504D51),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        getTimeAgo(index),
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF9A989A),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return AspirantReportPage(
                                          aspirantName: cred['mentorReports']
                                              [index]['full_name'],
                                          response1: cred['mentorReports']
                                              [index]['question_1'],
                                          response2: cred['mentorReports']
                                              [index]['question_2'],
                                          response3: cred['mentorReports']
                                              [index]['question_3'],
                                          reportId: cred['mentorReports'][index]
                                              ['report_id'],
                                        );
                                      }),
                                    );
                                  },
                                  child: Text(
                                    'View reports',
                                    style: GoogleFonts.raleway(
                                      color: AppTheme.kPurpleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {},
                            border: const Border(
                              top: BorderSide(
                                color: Color(0xFFF2EBF3),
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFF2EBF3),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  }
                ],
              );
            },
            error: (((error, stackTrace) => Text(error.toString()))),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }

  Future<bool?> goToMentorHomePage() async {
    AppNavigator.navigateToAndClear(mentorSkeletonRoute);
    return null;
  }
}

class AspirantReportModel {
  final String aspirantImage;
  final String names;
  final String minutesAgo;

  const AspirantReportModel(
    this.aspirantImage,
    this.names,
    this.minutesAgo,
  );
}
