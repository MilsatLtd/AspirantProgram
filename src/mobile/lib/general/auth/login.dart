import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../extras/components/files.dart';

final boolStateProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  'Welcome to your \nlearning space!',
                  style: kThickAppTextStyle,
                ),
                SizedBox(
                  height: 56.h,
                ),
                Text(
                  'Email',
                  style: kOnboardingLightTextStyle,
                ),
                SizedBox(
                  height: 8.h,
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
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Password',
                  style: kOnboardingLightTextStyle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final tapped = ref.watch(boolStateProvider);
                    if (kDebugMode) {
                      print(tapped);
                    }
                    return CustomTextField(
                      controller: passwordController,
                      hintText: 'Input password here',
                      validator: (a) {
                        return Utils.isValidPassword(a!);
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 10.w,
                        ),
                        child: IconButton(
                          onPressed: () {
                            ref.read(boolStateProvider.notifier).state =
                                !tapped;
                          },
                          icon: tapped
                              ? Icon(
                                  Icons.remove_red_eye,
                                  size: 18.sp,
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
                    AppNavigator.navigateTo(forgotPasswordRoute);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Forget password?',
                    style: kForgotPasswordStyle,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final state = ref.watch(signInProvider);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: ref.watch(signInProvider).loading
                              ? null
                              : () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  DecodedTokenResponse? decodedToken =
                                      await SecureStorageUtils
                                          .getDataFromStorage<
                                                  DecodedTokenResponse>(
                                              SharedPrefKeys.tokenResponse,
                                              DecodedTokenResponse
                                                  .fromJsonString);
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    await ref
                                        .read(signInProvider.notifier)
                                        .signIn(emailController.text.trim(),
                                            passwordController.text.trim());
                                    await ref
                                        .read(apiServiceProvider)
                                        .getUserData(decodedToken!.userId);
                                  }
                                },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double?>(0),
                            minimumSize: MaterialStateProperty.all<Size>(Size(
                              double.infinity,
                              54.h,
                            )),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppTheme.kPurpleColor),
                          ),
                          child: ref.watch(signInProvider).loading
                              ? const CircularProgressIndicator(
                                  color: AppTheme.kAppWhiteScheme,
                                )
                              : Text(
                                  'Login',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16.sp,
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
    );
  }
}
