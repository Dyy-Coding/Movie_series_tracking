import 'package:get/get.dart';
import 'package:movie_app/app/modules/authentication/screen/forgot_password/reset_password_screen.dart';
import 'package:movie_app/app/modules/authentication/screen/login/login.dart';
import 'package:movie_app/app/modules/authentication/screen/onboarding/onboarding.dart';
import 'package:movie_app/app/modules/authentication/screen/register/register_screen.dart';
import 'package:movie_app/app/modules/favorite/binding/favorite_binding.dart';
import 'package:movie_app/app/modules/favorite/screens/favorite_screen.dart';
import 'package:movie_app/app/modules/movies/binding/movie_detail_binding.dart';
import 'package:movie_app/app/modules/movies/binding/movie_search_binding.dart';
import 'package:movie_app/app/modules/movies/screens/movie_screen.dart';
import 'package:movie_app/app/modules/movies/screens/widget/showDetail/show_detail_sreen.dart';
import 'package:movie_app/app/modules/profiles/binding/edit_profile_binding.dart';
import 'package:movie_app/app/modules/profiles/binding/profile_binding.dart';
import 'package:movie_app/app/modules/profiles/screens/prodile_screen.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/edit_profile/edit_profile.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/setting_profile/setting_profile.dart';
import 'package:movie_app/app/modules/seriesscreen/binding/series_binding.dart';
import 'package:movie_app/app/modules/seriesscreen/screens/series_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.ONBOARDING, page: () => OnBoardingScreen()),
    GetPage(
      name: '/',
      page: () => const MovieScreen(),
      binding: MovieSearchBinding(),
    ),
    GetPage(
      name: "/favorite",
      page: () => const FavoriteScreen(),
      binding: FavoriteBinding(), // ✅ Attach the binding here
    ),

    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileScreen(),
      binding: EditProfileBindings(),
      // ✅ Attach the binding here
    ),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterScreen()),
    GetPage(
      name: AppRoutes.RESETPASSWORD,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: '/series',
      page: () => const SeriesScreen(),
      binding: SeriesBinding(),
    ),
    GetPage(
      name: "/edit_profile",
      page: () => const EditProfile(),
      binding: EditProfileBindings(),
    ),
    GetPage(
      name: "/setting", 
      page: () => SettingsScreen(),
      binding: ProfileBinding(),
      ),
     GetPage(
      name: "/movie_detail", 
      page: () => MovieDetailsScreen(),
      binding: MovieDetailsBinding(),
      ),
  ];
}
