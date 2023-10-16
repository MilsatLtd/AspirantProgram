import 'package:flutter/material.dart';

import '../extras/components/files.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: 16..w,
      ),
      child: CustomButton(
        elevation: 0,
        height: 54.h,
        pressed: () {
          AppNavigator.navigateToAndClear(loginRoute);
        },
        color: AppTheme.kPurpleColor,
        width: double.infinity,
        borderRadius: BorderRadius.circular(8.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: kCustomButtonTextStyle,
            ),
            SizedBox(
              width: 16.w,
            ),
            Icon(
              Icons.arrow_forward,
              size: 16.sp,
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
            height: 660.19.h,
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
                      SizedBox(
                        height: 122.h,
                      ),
                      SvgPicture.asset(
                        contents[index].image,
                        height: 274.19.h,
                        width: 276.7.w,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 96.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 168.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contents[index].title,
                                    style: kOnboardingThickTextStyle,
                                  ),
                                  SizedBox(height: 24.h),
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
          SizedBox(height: 36.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildContainer(index, context),
            ),
          ),
          SizedBox(height: 24.h),
          if (currentIndex == contents.length - 1)
            onboardButton
          else
            Container(),
        ],
      ),
    );
  }

  Widget buildContainer(int index, BuildContext context) {
    return Container(
      width: 8.w,
      height: 4.w,
      margin: EdgeInsets.only(left: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: currentIndex == index
            ? AppTheme.kPurpleColor
            : AppTheme.kLightPurpleColor,
      ),
    );
  }
}
