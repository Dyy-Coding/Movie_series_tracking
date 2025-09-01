import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:movie_app/app/modules/favorite/screens/widget/favorite_content.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

/// =====================
/// Favorite Screen (uses routes)
/// =====================
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject FavoriteController (only once, safe if already exists)
    final FavoriteController controller = Get.put(FavoriteController());

    final currentRoute = Get.currentRoute;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: UColors.scaffoldBackground,
      body: FavoriteContent(controller: controller),
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
              Get.offNamed('/favorite'); // already here
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

  /// ✅ AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "⭐ Favorites",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
      ),
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
