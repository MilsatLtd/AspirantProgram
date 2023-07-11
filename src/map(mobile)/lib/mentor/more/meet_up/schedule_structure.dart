import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class ScheduleStructure extends StatelessWidget {
  const ScheduleStructure({
    super.key,
    required this.title,
    required this.scheduleTime,
    required this.scheduleDate,
    required this.onTap,
    required this.onTap1,
  });

  final String title;
  final String scheduleTime;
  final String scheduleDate;
  final Function() onTap;
  final Function() onTap1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      height: 76.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFFF2EBF3),
        ),
      ),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.raleway(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF504D51),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Text(
                          scheduleDate,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF504D51),
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          scheduleTime,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF504D51),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 110.w,
              ),
              IconButton(
                onPressed: onTap1,
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
