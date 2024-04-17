import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorProfileCardContent extends ConsumerWidget {
  const MentorProfileCardContent({required this.trackName, super.key});

  final String trackName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int point = 000;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 14.36,
          ),
          Text(
            'Track',
            style: GoogleFonts.raleway(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF2EBF3),
              height: 1.8,
            ),
          ),
          Text(
            trackName,
            style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF2EBF3),
              height: 1.8,
            ),
          ),
          const SizedBox(
            height: 20.14,
          ),
          Text(
            'Ranking: $point pts',
            style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF2EBF3),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
