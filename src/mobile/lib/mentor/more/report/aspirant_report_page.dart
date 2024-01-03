import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class AspirantReportPage extends StatelessWidget {
  const AspirantReportPage({
    super.key,
    required this.aspirantName,
    required this.response1,
    required this.response2,
    required this.response3,
  });

  final String aspirantName;
  final String response1;
  final String response2;
  final String response3;

  @override
  Widget build(BuildContext context) {
    List<AspirantReportStructure> structure = [
      AspirantReportStructure(
        'What course did you take this week?',
        'Application of remote sensing and GIS in hydrology',
      ),
      AspirantReportStructure(
        'What did you learn during the course of the week?',
        'During the course of the week, i learnt valuable skills and knowledge in various fields, '
            'such as geospatial analysis, data visualization, machine learning, and web development.'
            'Throughout my learning journey, i will encounter challenges and blockers, but my '
            'mentor guides me and help overcome these obstacles. ',
      ),
      AspirantReportStructure(
        'How will you apply what you have learnt?',
        'I learn to analyze and visualize geographic data, which can be useful in fields such as urban '
            'planning, environmental science, and public health. If I\'m taking a data visualization course, '
            'I can apply the best practices and design principles I learn to create clear and effective data '
            'visualizations that communicate insights and support decision-making. If I\'m taking a machine '
            'learning course, I can apply the algorithms and techniques I learn to solve real-world problems, '
            'such as predicting customer behavior or detecting fraud. Finally, if I\'m taking a web development'
            ' course, I can apply the coding and design skills I learn to create responsive and user-friendly '
            'websites that meet client needs and industry standards. '
            'By applying what I learn as a student, I can enhance my skills, build my portfolio, and achieve my career goals.',
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
              AppNavigator.doPop();
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
                  onTap: () {},
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
