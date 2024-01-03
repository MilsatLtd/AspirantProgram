import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

double userProgress = 0;

class TrackContent extends StatefulWidget {
  const TrackContent({
    super.key,
    required this.onTap,
    this.maxLines,
    this.overflow,
    required this.courseContent,
    required this.text,
    required this.height,
    required this.d,
  });

  final String courseContent;
  final String text;
  final double height;
  final Function() onTap;
  final int? maxLines;
  final TextOverflow? overflow;
  final CourseModel d;

  @override
  State<TrackContent> createState() => _TrackContentState();
}

class _TrackContentState extends State<TrackContent> {
  @override
  Widget build(BuildContext context) {
    getNumber() {
      List courses = widget.d.courses!;
      int value = 0;
      for (var i in courses) {
        if (i.canView == true) {
          value++;
        } else {
          return value;
        }
      }
      return value;
    }

    int val = getNumber();

    if (kDebugMode) {
      print(val);
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 56,
            child: Text(
              widget.d.name!,
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.75,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: widget.height,
            child: Text(
              widget.courseContent,
              maxLines: widget.maxLines,
              overflow: widget.overflow,
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.75,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Courses: ',
                    style: GoogleFonts.raleway(
                      color: AppTheme.kAppWhiteScheme,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$val/${widget.d.courses!.length}',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFFCBADCD),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  widget.text,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.75,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
