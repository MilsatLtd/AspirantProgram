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

// Create a custom FAB location
class CustomFabLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetX;
  final double offsetY;

  CustomFabLocation({
    required this.location,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset standardPosition = location.getOffset(scaffoldGeometry);
    return Offset(
      standardPosition.dx + offsetX,
      standardPosition.dy + offsetY,
    );
  }
}
