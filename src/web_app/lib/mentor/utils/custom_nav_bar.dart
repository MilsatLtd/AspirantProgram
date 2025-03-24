import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          image,
          const SizedBox(
            height: 3,
          ),
          Text(
            label,
            style: GoogleFonts.raleway(
              fontSize: 13,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
