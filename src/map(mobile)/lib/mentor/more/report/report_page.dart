import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

final submittedReport = FutureProvider((ref) {
  return ref.read(apiServiceProvider).getSubmmittedReport_();
});

class ReportPageMentor extends ConsumerWidget {
  const ReportPageMentor({super.key});

  @override
  Widget build(BuildContext context, ref) {
    getTimeAgo<String>(index) {
      int time = cred['reports'][index]['age'];
      double timeInHours = time / 60;
      if (timeInHours > 24 && timeInHours < 48) {
        return '1 day ${48 - 24} hours ago';
      } else {
        return '${timeInHours.floorToDouble()} hours ago';
      }
    }

    final reports = ref.watch(submittedReport);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.h),
        child: AppBar(
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              AppNavigator.pop();
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
              fontSize: 16.sp,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Text(
                    'This Week',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (cred['reports'] == null)
                  const Center(
                    child: Text('No submitted report yet'),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: cred['reports'].length,
                      itemBuilder: ((context, index) {
                        return AspirantsTile(
                          image: cred['reports'][index]['profile_picture'],
                          column: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cred['reports'][index]['full_name'],
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF504D51),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      getTimeAgo(index),
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF9A989A),
                                        fontSize: 11.sp,
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
                                        aspirantName: cred['reports'][index]
                                            ['full_name'],
                                        response1: cred['reports'][index]
                                            ['question_1'],
                                        response2: cred['reports'][index]
                                            ['question_2'],
                                        response3: cred['reports'][index]
                                            ['question_3'],
                                      );
                                    }),
                                  );
                                },
                                child: Text(
                                  'View reports',
                                  style: GoogleFonts.raleway(
                                    color: AppTheme.kPurpleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
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
    );
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
