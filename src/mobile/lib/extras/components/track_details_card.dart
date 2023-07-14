import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class TrackDetailsCard extends StatelessWidget {
  const TrackDetailsCard({
    super.key,
    required this.itemPosition,
    required this.trackName,
    required this.color,
    required this.textColor,
    required this.submittedCertificate,
    required this.borderColor,
    required this.buttonTextColor,
    required this.backGroundColor,
  });

  final Widget itemPosition;
  final String trackName;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Color buttonTextColor;
  final Color backGroundColor;
  final Function() submittedCertificate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFEEEDEE),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                itemPosition,
                SizedBox(
                  width: 8.w,
                ),
                SizedBox(
                  width: 180.w,
                  child: Text(
                    trackName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: GoogleFonts.raleway(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: submittedCertificate,
              style: OutlinedButton.styleFrom(
                backgroundColor: backGroundColor,
                side: BorderSide(
                  color: borderColor,
                  width: 0.8,
                ),
                minimumSize: Size(
                  74.w,
                  24.h,
                ),
              ),
              child: Text(
                'View course',
                style: GoogleFonts.raleway(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: buttonTextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
