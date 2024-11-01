import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../extras/api/change_password.dart';
import '../../../extras/components/files.dart';

class PasswordPage extends ConsumerWidget {
  static const String name = 'password-page';
  static const String route = '/password-page';
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
            context.pop();
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Old Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: const Color(0xFF504D51),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'New Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: const Color(0xFF504D51),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Confirm Password',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: const Color(0xFF504D51),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              CustomButton(
                height: 54,
                pressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final data = {
                    "old_password": oldPasswordController.text,
                    "new_password": newPasswordController.text,
                    "new_password_confirm": confirmPasswordController.text,
                  };
                  await ref.read(changePasswordProvider).changePassword(data);
                  // ignore: use_build_context_synchronously
                  popUp(context, ref);
                },
                color: AppTheme.kPurpleColor,
                width: double.infinity,
                borderRadius: BorderRadius.circular(8),
                elevation: 0,
                child: Text(
                  'Change Password',
                  style: GoogleFonts.raleway(
                    color: AppTheme.kAppWhiteScheme,
                    fontSize: 14,
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF383639),
            ),
          ),
          content: Text(
            personalInfo["message"].toString(),
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
              pressed: () {
                personalInfo["message"].toString().contains('400')
                    ? context.pop()
                    : context.go(LoginScreen.route);
              },
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
}
