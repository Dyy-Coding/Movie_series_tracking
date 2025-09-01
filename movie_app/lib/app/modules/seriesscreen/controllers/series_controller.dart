import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/movies_data.dart';
import 'package:movie_app/app/data/models/movie.dart';

class SeriesController extends GetxController {
  // Text controller for search field
  final TextEditingController searchController = TextEditingController();

  // Selected category
  final RxString selectedCategory = "All".obs;

  // Filtered series to display
  final RxList<MovieItem> filteredSeries = <MovieItem>[].obs;

  // All series from data source
  final List<MovieItem> allSeries = seriesList;

  @override
  void onInit() {
    super.onInit();
    // Initially show all series
    filteredSeries.assignAll(allSeries);
    // Listen to search input changes
    searchController.addListener(_onSearchChanged);
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
          category == "All" ||
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
