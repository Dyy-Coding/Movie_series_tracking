import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/binding/profile_binding.dart';
import 'package:movie_app/app/modules/profiles/controllers/theme_controller.dart';
import 'package:movie_app/app/utils/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase correctly
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ThemeController early to set theme before build
    Get.put(ThemeController());

    return Obx(() {
      final themeController = Get.find<ThemeController>();

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.ONBOARDING,
        getPages: AppPages.routes,
        initialBinding: ProfileBinding(), // Apply bindings for controllers
        theme: UAppTheme.darkTheme,
        darkTheme: UAppTheme.lightTheme,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
