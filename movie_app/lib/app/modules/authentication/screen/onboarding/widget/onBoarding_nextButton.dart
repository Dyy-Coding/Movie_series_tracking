
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/common/widgets/button/elevated_button.dart';
import 'package:movie_app/app/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      left: 0,
      right: 0,
      bottom: USizes.spaceLarge,
      child: Obx(() => UElevatedButton(
        child: Text(controller.currentIndex.value == 2 ? "Get Started" : "Next"),
        onPressed: controller.nextPage,
      )),
    );
  }
}
