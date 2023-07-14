import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class ProfileCardContent extends ConsumerWidget {
  const ProfileCardContent({required this.trackName, super.key});

  final String trackName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int point = 000;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 14.36.h,
          ),
          Text(
            'Track',
            style: GoogleFonts.raleway(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF2EBF3),
              height: 1.8.h,
            ),
          ),
          Text(
            trackName,
            style: GoogleFonts.raleway(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF2EBF3),
              height: 1.8.h,
            ),
          ),
          SizedBox(
            height: 20.14.h,
          ),
          Text(
            'Ranking: $point pts',
            style: GoogleFonts.raleway(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF2EBF3),
              height: 1.8.h,
            ),
          ),
        ],
      ),
    );
  }
}
