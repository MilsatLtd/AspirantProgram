// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/forgot_password.dart';
import 'package:milsat_project_app/extras/components/widgets.dart';
import 'package:milsat_project_app/extras/models/forgot_password_model.dart';

import '../../../extras/components/files.dart';
import '../../../main.dart';

class InputTokenPage extends ConsumerStatefulWidget {
  static const String name = 'input-token';
  static const String route = '/input-token';
  const InputTokenPage({super.key});

  @override
  ConsumerState<InputTokenPage> createState() => _InputTokenPageState();
}

class _InputTokenPageState extends ConsumerState<InputTokenPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tokenController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                child: Center(
                  child: SizedBox(
                    width: screenWidthPercentage,
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
                              'Input New Password',
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
                              'Enter the token sent to your mail to reset your password',
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
                              'Token',
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
                              controller: tokenController,
                              hintText: '234524',
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              validator: (a) {
                                return Utils.isValidToken(a!);
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'New Password',
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
                                controller: newPasswordController,
                                hintText: 'new password',
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                validator: (a) {
                                  return Utils.isValidPassword(a!);
                                }),
                            const SizedBox(height: 24),
                            Text(
                              'Confirm Password',
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
                                controller: confirmPasswordController,
                                hintText: 're-enter password',
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                validator: (a) {
                                  return Utils.isValidPassword(a!);
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
                                      .inputToken(
                                        int.parse(tokenController.text),
                                        newPasswordController.text,
                                        confirmPasswordController.text,
                                      );

                                  hasError
                                      ? popUpCard(
                                          context,
                                          'Hello!',
                                          message.message ??
                                              message.nonFieldErrors![0], () {
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
                                          context.go(LoginScreen.route);
                                          hasError = false;
                                        });
                                }
                              },
                              color: AppTheme.kPurpleColor,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(8),
                              child: Text(
                                'Reset Password',
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
