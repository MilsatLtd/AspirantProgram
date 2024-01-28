import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFEEEDEE),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                itemPosition,
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    trackName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: GoogleFonts.raleway(
                      fontSize: 16,
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
                minimumSize: const Size(
                  74,
                  24,
                ),
              ),
              child: Text(
                'View course',
                style: GoogleFonts.raleway(
                  fontSize: 10,
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
