import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/binding/profile_binding.dart';
import 'package:movie_app/app/modules/profiles/controllers/theme_controller.dart';
import 'package:movie_app/app/utils/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ThemeController early to set theme before build
    Get.put(ThemeController());
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.ONBOARDING,
      getPages: AppPages.routes,
      initialBinding: ProfileBinding(), // Apply bindings for controllers
      theme: UAppTheme.darkTheme,
      darkTheme: UAppTheme.lightTheme,
      themeMode: Get.find<ThemeController>().isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}