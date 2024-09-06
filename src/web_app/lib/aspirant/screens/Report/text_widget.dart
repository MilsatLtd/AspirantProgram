import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../extras/components/files.dart';

class ReportPage2 extends StatelessWidget {
  const ReportPage2({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
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
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How do you plan on applying what you learnt this week?',
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
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'enter here',
                  hintStyle: GoogleFonts.raleway(
                    color: AppTheme.kHintTextColor,
                  ),
                ),
                maxLines: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.raleway(
                        color: AppTheme.kPurpleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 350.h,
                  // ),
                  OutlinedButton(
                    onPressed: () {},
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
    );
  }
}
