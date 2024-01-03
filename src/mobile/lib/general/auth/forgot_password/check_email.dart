import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 175),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 168,
                width: 168,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF2EBF3).withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/email_svg.svg',
                    height: 54.54,
                    width: 60.96,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            Text(
              'Check your Email',
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: const Color(0xFF383639),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'A reset has been sent to your mail,\n'
              'follow the instruction ',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color(0xFF6E6B6F),
                height: 1.75,
              ),
            ),
            const SizedBox(
              height: 138,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t receive mail:',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: const Color(0xFF383639),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppTheme.kPurpleColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
