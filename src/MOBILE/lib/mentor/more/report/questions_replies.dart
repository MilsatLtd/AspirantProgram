import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class AspirantReportStructure {
  final String question;
  final String response;

  AspirantReportStructure(
    this.question,
    this.response,
  );
}

class ResponseBody extends StatelessWidget {
  const ResponseBody({
    super.key,
    required this.question,
    required this.response,
  });

  final String question;
  final String response;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF504D51),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          response,
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6E6B6F),
            fontSize: 16.sp,
            height: 2.h,
          ),
        ),
      ],
    );
  }
}
