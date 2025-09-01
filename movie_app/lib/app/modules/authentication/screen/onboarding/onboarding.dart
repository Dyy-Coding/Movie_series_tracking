import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/widget/onBoarding_nextButton.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/widget/onboarding_dotnavigation.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/widget/onboarding_page.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/widget/onboarding_skip.dart';
import 'package:movie_app/app/utils/constants/images.dart';
import 'package:movie_app/app/utils/constants/sizes.dart';
import 'package:movie_app/app/utils/constants/texts..dart';
import 'package:movie_app/app/utils/helpers/device_helpers.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      // backgroundColor: const Color.fromARGB(133, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: USizes.spaceMedium),
        child: Stack(
          children: [
            // PageView
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(
                  animation: Uimages.onBoarding1Animation,
                  title: UTexts.onBoardingTitle1,
                  subTitle: UTexts.onBoardingSubTitle1,
                  textColor: const Color.fromARGB(255, 3, 3, 3),
                ),
                OnBoardingPage(
                  animation: Uimages.onBoarding2Animation,
                  title: UTexts.onBoardingTitle2,
                  subTitle: UTexts.onBoardingSubTitle2,
                  textColor: const Color.fromARGB(255, 5, 5, 5),
                ),
                OnBoardingPage(
                  animation: Uimages.onBoarding3Animation,
                  title: UTexts.onBoardingTitle3,
                  subTitle: UTexts.onBoardingSubTitle3,
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),

            // Dot indicator - centered horizontally, slightly above buttons
            Positioned(
              bottom: 120 + UDevicesHelper.getBottomNavigationBarHeight(),
              left: 0,
              right: 0,
              child: Center(child: OnBoardingDotNavigation()),
            ),

            // Next button - bottom right
             OnBoardingNextButton(),
  

          
             OnBoardingSkipButton(),
            
          ],
        ),
      ),
    );
  }
}
