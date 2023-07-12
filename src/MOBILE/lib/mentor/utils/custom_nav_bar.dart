import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CustomButtonNavBarItem extends StatelessWidget {
  const CustomButtonNavBarItem({
    super.key,
    required this.image,
    required this.label,
    required this.onPressed,
    required this.textColor,
  });

  final Widget image;
  final String label;
  final Color textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          image,
          SizedBox(
            height: 3.h,
          ),
          Text(
            label,
            style: GoogleFonts.raleway(
              fontSize: 13.sp,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
