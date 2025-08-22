
import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:movie_app/app/utils/helpers/device_helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: UDevicesHelper.getBottomNavigationBarHeight() * 4,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: controller.pageController, // Use the shared controller
          count: 3,
          effect: const ExpandingDotsEffect(dotHeight: 6.0),
          onDotClicked: (index) {
            controller.dotNavigationClick(index);
          },
        ),
      ),
    );
  }
}
