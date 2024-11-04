// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/forgot_password.dart';
import 'package:milsat_project_app/extras/components/widgets.dart';
import 'package:milsat_project_app/extras/models/forgot_password_model.dart';
import 'package:milsat_project_app/general/auth/forgot_password/input_token.dart';

import '../../../extras/components/files.dart';
import '../../../main.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  static const String name = 'forgot-password';
  static const String route = '/forgot-password';
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController profileController = TextEditingController();

  ForgotPasswordResponse message = ForgotPasswordResponse();

  // Variable to store the calculated width
  double? screenWidthPercentage;

  @override
  void initState() {
    super.initState();

    screenWidthPercentage = screenWidth > 800
        ? screenWidth * 0.25 // Desktop view (25% of screen width)
        : screenWidth * 0.9; // Mobile view (90% of screen width)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          leading: InkWell(
            onTap: context.pop,
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
        ),
        body: screenWidthPercentage == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 100,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: screenWidthPercentage,
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
                                  return Utils.isValidName(
                                      a, 'profile_type', 5);
                                }),
                            const SizedBox(
                              height: 56,
                            ),
                            CustomButton(
                              height: 54,
                              pressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  message = await ref
                                      .read(forgotPasswordProvider)
                                      .forgotPassword(
                                        emailController.text,
                                        profileController.text,
                                      );
                                  hasError
                                      ? popUpCard(context, 'Hello!',
                                          message.profileType![0], () {
                                          context.canPop()
                                              ? context.pop()
                                              : context.pushReplacement(
                                                  HomeScreen.route);
                                          setState(() {
                                            hasError = false;
                                          });
                                        })
                                      : popUpCard(
                                          context, 'Hello!', message.message!,
                                          () {
                                          context.push(InputTokenPage.route);
                                          hasError = false;
                                        });
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
                  ),
                ),
              ));
  }
}
