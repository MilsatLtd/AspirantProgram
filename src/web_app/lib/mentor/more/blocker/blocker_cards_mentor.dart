import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockerCards extends StatelessWidget {
  const BlockerCards({
    super.key,
    required this.text,
    required this.textColor,
    this.boxColor,
    this.border,
    required this.onTap,
  });

  final String text;
  final Function() onTap;
  final Color textColor;
  final Color? boxColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: boxColor,
          border: border,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.raleway(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
