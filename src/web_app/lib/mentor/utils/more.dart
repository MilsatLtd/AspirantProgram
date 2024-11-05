// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class MorePages extends StatelessWidget {
  const MorePages({
    super.key,
    required this.image,
    required this.onTap,
    required this.pageName,
    required this.pageDescription,
    required this.width,
  });

  final String image;
  final String pageName;
  final String pageDescription;
  final double width;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        height: 40,
        child: Row(
          children: [
            SvgPicture.asset(
              image,
              height: 18,
              width: 18,
              color: AppTheme.kPurpleColor,
            ),
            SizedBox(
              width: width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pageName,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF504D51),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  pageDescription,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF504D51),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
