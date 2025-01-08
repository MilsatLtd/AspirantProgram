import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class DateOrTimeHolder extends StatelessWidget {
  const DateOrTimeHolder({
    super.key,
    required this.dateFormat,
    required this.heading,
    required this.onTap,
    required this.textColor,
  });

  final String dateFormat;
  final String heading;
  final Function() onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.raleway(
            color: const Color(0xFF504D51),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 163.5,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppTheme.kHintTextColor,
              ),
            ),
            child: Center(
              child: Text(
                dateFormat,
                style: GoogleFonts.raleway(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
