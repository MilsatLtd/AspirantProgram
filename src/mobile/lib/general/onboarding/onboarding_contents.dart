import 'package:flutter/material.dart';

class OnboardingContent {
  String image;
  String title;
  String description;
  String buttonDescription;
  Icon? onboardButton;

  OnboardingContent(
      {required this.image,
      required this.title,
      required this.description,
      required this.buttonDescription,
      this.onboardButton});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    image: 'assets/onboarding_image1.svg',
    buttonDescription: '',
    title: 'Explore the world with \ngeospatial skills',
    description:
        'Join our community of learners and mentors to gain valuable insights and hands-on experience!',
  ),
  OnboardingContent(
    image: 'assets/onboarding_image2.svg',
    title: 'Master geospatial tools',
    description:
        'Unlock your potential with personalized guidance from experienced mentors and industry experts',
    buttonDescription: '',
  ),
  OnboardingContent(
    image: 'assets/onboarding_image3.svg',
    title: 'Collaborate, conquer and \nsubmit track progress',
    description:
        'Submit your to-dos after completing a course to track your progress and receive feedback from mentors and peers. ',
    buttonDescription: 'Get Started',
    onboardButton: const Icon(
      Icons.arrow_forward,
    ),
  )
];
