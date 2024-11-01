import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/mentor/more/report/feedback_page.dart';

class AspirantReportPage extends StatelessWidget {
  const AspirantReportPage({
    super.key,
    required this.aspirantName,
    required this.response1,
    required this.response2,
    required this.response3,
    required this.reportId,
  });

  final String aspirantName;
  final String response1;
  final String response2;
  final String response3;
  final String reportId;

  @override
  Widget build(BuildContext context) {
    List<AspirantReportStructure> structure = [
      AspirantReportStructure(
        'What course did you take this week?',
        '',
      ),
      AspirantReportStructure(
        'What did you learn during the course of the week?',
        '',
      ),
      AspirantReportStructure(
        'How will you apply what you have learnt?',
        '',
      ),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          title: Text(
            aspirantName,
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: AppTheme.kAppWhiteScheme,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
            bottom: 44,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponseBody(
                question: structure[0].question,
                response: response1,
              ),
              const SizedBox(
                height: 24,
              ),
              ResponseBody(
                question: structure[1].question,
                response: response2,
              ),
              const SizedBox(
                height: 24,
              ),
              ResponseBody(
                question: structure[2].question,
                response: response3,
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return FeedbackPage(
                          reportId: reportId,
                        );
                      }),
                    );
                  },
                  child: Text(
                    'Give feedback',
                    style: GoogleFonts.raleway(
                      color: AppTheme.kPurpleColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
