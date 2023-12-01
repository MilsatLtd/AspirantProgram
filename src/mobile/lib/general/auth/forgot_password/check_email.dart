import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 175.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 168.h,
                width: 168.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF2EBF3).withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/email_svg.svg',
                    height: 54.54.h,
                    width: 60.96.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Text(
              'Check your Email',
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: const Color(0xFF383639),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              'A reset has been sent to your mail,\n'
              'follow the instruction ',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: const Color(0xFF6E6B6F),
                height: 1.75.h,
              ),
            ),
            SizedBox(
              height: 138.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t receive mail:',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    color: const Color(0xFF383639),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
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
