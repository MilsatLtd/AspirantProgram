import 'package:flutter/material.dart';

import '../../extras/components/files.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;

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
          AppNavigator.navigateToAndClear(loginRoute);
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
      body: Column(
        children: [
          SizedBox(
            height: 660.19,
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
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
                      const SizedBox(
                        height: 122,
                      ),
                      SvgPicture.asset(
                        contents[index].image,
                        height: 274.19,
                        width: 276.7,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 96),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 168,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contents[index].title,
                                    style: kOnboardingThickTextStyle,
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    contents[index].description,
                                    style: kOnboardingLightTextStyle,
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
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildContainer(index, context),
            ),
          ),
          const SizedBox(height: 24),
          if (currentIndex == contents.length - 1)
            onboardButton
          else
            Container(),
        ],
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
