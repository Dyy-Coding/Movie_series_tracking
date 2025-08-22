import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/screen/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  /// Update current index when page scroll
  void updatePageIndicator(index){
    currentIndex.value = index;
  }

  /// Jump to specific dot selected page
  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update current index and jump to the next page
  void nextPage(){
    if(currentIndex.value == 2){
      Get.offAll(()=> LoginScreen());
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  ///Update current index jump to the past page
  void skipPage(){
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }

}