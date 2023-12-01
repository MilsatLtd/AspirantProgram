import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extras/components/files.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _onboardScreen();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool('onboardingShown') ?? false;

    if (onboardingShown) {
      setState(() {
        _showOnboarding = false;
      });
    } else {
      setState(() {
        _showOnboarding = true;
        prefs.setBool('onboardingShown', true);
      });
    }
  }

  _onboardScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    _showOnboarding
        ? AppNavigator.navigateToAndReplace(onboardRoute)
        : AppNavigator.navigateToAndReplace(loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/splash_image.svg',
        ),
      ),
    );
  }
}
