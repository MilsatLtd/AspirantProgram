import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Reset Password',
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
            'Enter the mail associated with your profile and a reset \nmail will be sent',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: const Color(0xFF6E6B6F),
              height: 1.5.h,
            ),
          ),
          SizedBox(
            height: 34.h,
          ),
          Text(
            'Email',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: const Color(0xFF504D51),
              height: 1.5.h,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          const CustomTextField(
            hintText: 'milsataspirant@gmail.com',
            obscureText: false,
          ),
          SizedBox(
            height: 56.h,
          ),
          CustomButton(
            height: 54.h,
            pressed: () {
              AppNavigator.navigateTo(checkImageRoute);
            },
            color: AppTheme.kPurpleColor,
            width: double.infinity,
            borderRadius: BorderRadius.circular(8.r),
            child: Text(
              'Reset',
              style: GoogleFonts.raleway(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.kAppWhiteScheme,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
