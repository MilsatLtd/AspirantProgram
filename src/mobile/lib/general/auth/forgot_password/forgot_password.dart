import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Reset Password',
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
            'Enter the mail associated with your profile and a reset \nmail will be sent',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: const Color(0xFF6E6B6F),
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            'Email',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: const Color(0xFF504D51),
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomTextField(
            hintText: 'milsataspirant@gmail.com',
            obscureText: false,
          ),
          const SizedBox(
            height: 56,
          ),
          CustomButton(
            height: 54,
            pressed: () {
              AppNavigator.navigateTo(checkImageRoute);
            },
            color: AppTheme.kPurpleColor,
            width: double.infinity,
            borderRadius: BorderRadius.circular(8),
            child: Text(
              'Reset',
              style: GoogleFonts.raleway(
                fontSize: 14,
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
