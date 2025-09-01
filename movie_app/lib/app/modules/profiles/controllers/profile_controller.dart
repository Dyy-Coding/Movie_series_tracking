import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/movies_data.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/data/models/user_profile.dart';

class ProfileController extends GetxController {
  // Text controller for search field
  final TextEditingController searchController = TextEditingController();

  // Selected category
  final RxString selectedCategory = "Reviews".obs;

  // Filtered series to display
  final RxList<MovieItem> filteredSeries = <MovieItem>[].obs;

  // All series from data source
  final List<MovieItem> allSeries = seriesList;

  var user = UserProfile(
    name: "Chandy Neat",
    username: "@chandy",
    avatar: "https://i.pinimg.com/736x/66/c7/a0/66c7a02621df47e1c51ccae8f2d0bf01.jpg",
  ).obs;

  void logout() {
  // Clear user session or authentication tokens
  // Example: await storage.erase();

  // Navigate to login and remove all previous routes
  Get.offAllNamed("/login");
  }

  void editProfile() {
    // Navigate to the Edit Profile screen
    Get.toNamed("/edit_profile");
  }


  void openSettings() {
    // TODO: navigate to settings
    Get.toNamed("/setting");

  }

  @override
  void onInit() {
    super.onInit();
    // Initially show all series
    filteredSeries.assignAll(allSeries);
    // Listen to search input changes
    searchController.addListener(_onSearchChanged);
  }

  /// Toggle menu visibility
  var isMenuVisible = false.obs;

  void toggleMenu() {
    isMenuVisible.value = !isMenuVisible.value;
  }

  /// Called whenever search input changes
  void _onSearchChanged() {
    filterBySearch(searchController.text);
  }

  /// Filter series by search query
  void filterBySearch(String query) {
    _applyFilters(query.toLowerCase(), selectedCategory.value);
  }

  /// Filter series by category
  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters(searchController.text.toLowerCase(), category);
  }

  /// Core filtering logic
  void _applyFilters(String query, String category) {
    final filtered = allSeries.where((item) {
      // Check category: show all if "All", otherwise match item's category
      final matchesCategory =
          category == "Reviews" ||
          item.category.toLowerCase() == category.toLowerCase();
      // Check search query
      final matchesSearch = item.title.toLowerCase().contains(
        query.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    // Update the reactive list for the UI
    filteredSeries.assignAll(filtered);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
