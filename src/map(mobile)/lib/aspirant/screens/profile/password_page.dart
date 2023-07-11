import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../extras/api/reset_password.dart';
import '../../../extras/components/files.dart';

class PasswordPage extends ConsumerWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AppNavigator.pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Password',
          style: GoogleFonts.raleway(
            color: const Color(0xFF504D51),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 32.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Old Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFF504D51),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'New Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFF504D51),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Confirm Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: const Color(0xFF504D51),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              CustomButton(
                height: 54.h,
                pressed: () async {
                  final data = {
                    "old_password": oldPasswordController.text,
                    "new_password": newPasswordController.text,
                    "new_password_confirm": confirmPasswordController.text,
                  };
                  await ref.read(resetPasswordProvider).resetPassword(data);
                  // ignore: use_build_context_synchronously
                  popUp(context, ref);
                },
                color: AppTheme.kPurpleColor,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8.r),
                elevation: 0,
                child: Text(
                  'Change Password',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> popUp(BuildContext context, ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Hello Aspirant!',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF383639),
            ),
          ),
          content: Text(
            personalInfo["message"].toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF504D51),
            ),
          ),
          actions: [
            CustomButton(
              height: 54.h,
              pressed: () {
                AppNavigator.pop();
              },
              color: AppTheme.kPurpleColor,
              width: 307.w,
              elevation: 0,
              borderRadius: BorderRadius.circular(8.r),
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
}
