import 'package:flutter/cupertino.dart';
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

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: USizes.spaceMedium),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged:controller.updatePageIndicator,
              children: [
                OnBoardingPage(animation: Uimages.onBoarding1Animation,title: UTexts.onBoardingTitle1,subTitle:  UTexts.onBoardingSubTitle1),
              ],
            ),
            /// Indicator
            OnBoardingDotNavigation(),
            /// Bottom Button
            OnBoardingNextButton(),
            /// Skip Button
            OnBoardingSkipButton()
          ],
        ),
      ),
    );
  }
}



