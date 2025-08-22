import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/onboarding.dart';
import 'package:movie_app/app/modules/home/screens/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
    ),
  ];
}
