import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/app_color.dart';
import 'package:milsat_project_app/extras/components/custom_button.dart';

Future<dynamic> popUpCard(BuildContext context, String? titleString,
    String? content, Function() onPressed) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          titleString ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF383639),
          ),
        ),
        content: Text(
          content ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          CustomButton(
            height: 54,
            pressed: onPressed,
            color: AppTheme.kPurpleColor,
            width: 307,
            elevation: 0,
            borderRadius: BorderRadius.circular(8),
            child: Text(
              'Ok!',
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
              ),
            ),
          )
        ],
      );
    },
  );
}

class CircularLoadingWidget extends StatelessWidget {
  final Color? color;
  const CircularLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? Colors.white,
      ),
    );
  }
}
