import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/profile_content.dart';
import 'package:movie_app/app/modules/profiles/controllers/profile_controller.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/profile_menu.dart';
// Remove this if unused: import 'package:movie_app/app/modules/profiles/screens/widget/profile_menu.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Put controller ONCE
    final ProfileController controller = Get.put(ProfileController());

    final currentRoute = Get.currentRoute;

    return Scaffold(
      appBar: _buildAppBar(), // app bar uses Get.find to reuse same controller
      backgroundColor: UColors.scaffoldBackground,
      body: Stack(
        children: [
          ProfileContent(controller: controller),

          // Dim & close when tap outside
          Obx(() => controller.isMenuVisible.value
              ? Positioned.fill(
                  child: GestureDetector(
                    onTap: controller.toggleMenu,
                    child: Container(color: Colors.black.withOpacity(0.15)),
                  ),
                )
              : const SizedBox.shrink()),

          /// Triangle Menu overlay
          Obx(() => controller.isMenuVisible.value
              ? Positioned(
                  top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
                  right: 16,
                  child: const TriangleMenu(),
                )
              : const SizedBox.shrink()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(currentRoute),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offNamed('/');
              break;
            case 1:
              Get.offNamed('/series');
              break;
            case 2:
              Get.offNamed('/favorite');
              break;
            case 3:
              Get.offNamed('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Series"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  /// ✅ AppBar — use Get.find so we don't create another controller
  AppBar _buildAppBar() {
    final ProfileController controller = Get.find<ProfileController>();
    return AppBar(
      title: const Text(
        "Profile",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: controller.toggleMenu,
        ),
      ],
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.black,
      foregroundColor: Colors.redAccent,
    );
  }

  /// ✅ Sync bottom nav index with route
  int _getCurrentIndex(String currentRoute) {
    switch (currentRoute) {
      case '/':
        return 0;
      case '/series':
        return 1;
      case '/favorite':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }
}
