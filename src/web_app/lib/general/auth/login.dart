// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/mentor/profile/profile.dart';
import '../../extras/components/files.dart';
import '../../main.dart';

final boolStateProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'login';
  static const String route = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  // Variable to store the calculated width
  double? loginCardWidth;
  @override
  void initState() {
    super.initState();
    loginCardWidth = screenWidth > 800
        ? screenWidth * 0.25 // Desktop view (25% of screen width)
        : screenWidth * 0.9; // Mobile view (90% of screen width)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginCardWidth == null
          ? const CircularProgressIndicator() // Show loader until width is calculated
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: loginCardWidth,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Text(
                            'Welcome to your \nlearning space!',
                            style: kThickAppTextStyle,
                          ),
                          const SizedBox(
                            height: 56,
                          ),
                          Text(
                            'Email',
                            style: kOnboardingLightTextStyle,
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
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Password',
                            style: kOnboardingLightTextStyle,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              final tapped = ref.watch(boolStateProvider);
                              return CustomTextField(
                                controller: passwordController,
                                hintText: 'Input password here',
                                validator: (a) {
                                  return Utils.isValidPassword(a!);
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 10,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      ref
                                          .read(boolStateProvider.notifier)
                                          .state = !tapped;
                                    },
                                    icon: tapped
                                        ? const Icon(
                                            Icons.remove_red_eye,
                                            size: 18,
                                          )
                                        : SvgPicture.asset(
                                            'assets/eye_lash.svg',
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                obscureText: tapped ? false : true,
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(ForgotPassword.route);
                            },
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text(
                              'Forget password?',
                              style: kForgotPasswordStyle,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              final state = ref.watch(signInProvider);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: ref.watch(signInProvider).loading
                                        ? null
                                        : () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            if (formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              ref
                                                  .read(mentorImage.notifier)
                                                  .state = null;
                                              ref.read(image.notifier).state =
                                                  null;
                                              if (mounted) {
                                                await ref
                                                    .read(
                                                        signInProvider.notifier)
                                                    .signIn(
                                                        emailController.text
                                                            .trim(),
                                                        passwordController.text
                                                            .trim(),
                                                        context);

                                                DecodedTokenResponse?
                                                    decodedToken =
                                                    await SharedPreferencesUtil
                                                        .getModel<
                                                                DecodedTokenResponse>(
                                                            SharedPrefKeys
                                                                .tokenResponse,
                                                            (json) =>
                                                                DecodedTokenResponse
                                                                    .fromJson(
                                                                        json));
                                                await ref
                                                    .read(apiServiceProvider)
                                                    .getUserData(
                                                        decodedToken!.userId);
                                              }

                                              error = [];
                                            }
                                          },
                                    style: ButtonStyle(
                                      elevation:
                                          WidgetStateProperty.all<double?>(0),
                                      minimumSize:
                                          WidgetStateProperty.all<Size>(
                                              const Size(
                                        double.infinity,
                                        54,
                                      )),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              AppTheme.kPurpleColor),
                                    ),
                                    child: ref.watch(signInProvider).loading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: AppTheme.kAppWhiteScheme,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            'Login',
                                            style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  if (state.hasError)
                                    Text(
                                      state.error,
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  else if (state.success)
                                    const Text(
                                      'Sign in successful!',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  else
                                    const SizedBox.shrink()
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
