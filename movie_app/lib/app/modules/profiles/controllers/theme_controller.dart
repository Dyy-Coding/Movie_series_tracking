import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/utils/theme/app_theme.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = true.obs; // Default to dark mode

  @override
  void onInit() {
    super.onInit();
    // Defer theme initialization to avoid build-time state changes
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.changeTheme(isDarkMode.value ? UAppTheme.darkTheme : UAppTheme.lightTheme);
    });
    // Optional: Load saved theme preference (requires shared_preferences)
    // _loadThemePreference();
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeTheme(value ? UAppTheme.darkTheme : UAppTheme.lightTheme);
    // Optional: Save theme preference (requires shared_preferences)
    // _saveThemePreference(value);
  }

  // Optional: Persistence with shared_preferences
  /*
  void _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? true;
    Get.changeTheme(isDarkMode.value ? UAppTheme.darkTheme : UAppTheme.lightTheme);
  }

  void _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }
  */
}