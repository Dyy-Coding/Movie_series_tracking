import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:movie_app/app/utils/helpers/device_helpers.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Obx(() {
      // Hide skip button on last page
      if (controller.currentIndex.value == 2) return const SizedBox.shrink();

      return Positioned(
        top: UDevicesHelper.getAppBarHeight() + 16,
        right: 16,
        child: TextButton(
          onPressed: controller.nextPage,
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 0, 0, 0), // set text color
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text("Skip"),
        ),
      );
    });
  }
}
