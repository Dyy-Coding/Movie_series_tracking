import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/controllers/edit_profile_controller.dart';
import 'package:movie_app/app/modules/profiles/controllers/profile_controller.dart';
import 'package:movie_app/app/modules/profiles/controllers/theme_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(), fenix: true);

  }
}
