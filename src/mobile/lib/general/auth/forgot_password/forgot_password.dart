import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/forgot_password.dart';

import '../../../extras/components/files.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController profileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 100,
        ),
        child: Form(
          key: _formKey,
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
              CustomTextField(
                  controller: emailController,
                  hintText: 'milsataspirant@gmail.com',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (a) {
                    return Utils.validateEmail(a!);
                  }),
              const SizedBox(height: 8),
              Text(
                'Profile Type',
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
              CustomTextField(
                  controller: profileController,
                  hintText: 'mentor or student',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (a) {
                    return Utils.isValidName(a, 'profile_type', 5);
                  }),
              const SizedBox(
                height: 56,
              ),
              CustomButton(
                height: 54,
                pressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState?.validate() ?? false) {
                    await ref.read(forgotPasswordProvider).forgotPassword(
                          emailController.text,
                          profileController.text,
                        );
                    AppNavigator.navigateTo(checkImageRoute);
                  }
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
        ),
      ),
    ));
  }
}
