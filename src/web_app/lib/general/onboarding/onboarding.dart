import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extras/components/files.dart';

class OnboardingScreen extends StatefulWidget {
  static const String name = 'onboarding-screen';
  static const String route = '/onboarding-screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget onboardButton = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: CustomButton(
        elevation: 0,
        height: 54,
        pressed: () {
          context.go(LoginScreen.route);
        },
        color: AppTheme.kPurpleColor,
        width: double.infinity,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: kCustomButtonTextStyle,
            ),
            const SizedBox(
              width: 16,
            ),
            const Icon(
              Icons.arrow_forward,
              size: 16,
              color: AppTheme.kAppWhiteScheme,
            )
          ],
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering = false;
                    });
                  },
                  child: SizedBox(
                    height: 490.19,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: contents.length,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int index) {
                        setState(
                          () {
                            currentIndex = index;
                          },
                        );
                      },
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50.0),
                                child: SvgPicture.asset(
                                  contents[currentIndex].image,
                                  height: 254.19,
                                  width: 256.7,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 140,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              contents[currentIndex].title,
                                              style: kOnboardingThickTextStyle,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Flexible(
                                            child: Text(
                                              contents[currentIndex]
                                                  .description,
                                              style: kOnboardingLightTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildContainer(index, context),
                  ),
                ),
                const SizedBox(height: 20),
                if (currentIndex == contents.length - 1)
                  onboardButton
                else
                  Container(),
              ],
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height / 2.5,
              right: 24,
              child: Visibility(
                visible: currentIndex < 2,
                child: AnimatedOpacity(
                  opacity: _isHovering ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: GestureDetector(
                    onTap: () {
                      if (currentIndex < 2) {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.kPurpleColor,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: AppTheme.kPurpleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height / 2.5,
              left: 24,
              child: Visibility(
                visible: currentIndex > 0,
                child: AnimatedOpacity(
                  opacity: _isHovering ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: GestureDetector(
                    onTap: () {
                      if (currentIndex > 0) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.kPurpleColor,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.kPurpleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(int index, BuildContext context) {
    return Container(
      width: 8,
      height: 4,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentIndex == index
            ? AppTheme.kPurpleColor
            : AppTheme.kLightPurpleColor,
      ),
    );
  }
}
