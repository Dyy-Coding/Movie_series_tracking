import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/data.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_search_controller.dart';
import 'package:movie_app/app/modules/movies/screens/widget/movie_content.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

/// =====================
/// Favorite Screen (uses routes)
/// =====================
class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Inject MovieSearchController if not already
    if (!Get.isRegistered<MovieSearchController>()) {
      Get.put(MovieSearchController(popularMovies)); // or seriesList depending on your data
    }

    final currentRoute = Get.currentRoute;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: UColors.scaffoldBackground,
      body: const MovieContent(), // controller is now available
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

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "🎥 Movie App",
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
