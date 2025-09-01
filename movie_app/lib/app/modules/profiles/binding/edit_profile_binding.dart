import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/controllers/edit_profile_controller.dart';
import 'package:movie_app/app/modules/profiles/controllers/theme_controller.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    // Lazily initialize ThemeController for SettingsScreen
    Get.lazyPut<ThemeController>(() => ThemeController());
    // Lazily initialize EditProfileController for EditProfile
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
