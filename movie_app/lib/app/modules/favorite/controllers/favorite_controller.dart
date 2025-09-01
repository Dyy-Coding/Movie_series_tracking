import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/review_data.dart';
import 'package:movie_app/app/data/models/movie.dart';

class FavoriteController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString selectedCategory = "All".obs;
  final RxList<MovieItem> filteredFavorite = <MovieItem>[].obs;

  // use your data here
  final List<MovieItem> allFavorite = favoriteMovies;

  @override
  void onInit() {
    super.onInit();
    filteredFavorite.assignAll(allFavorite);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    filterBySearch(searchController.text);
  }

  void filterBySearch(String query) {
    _applyFilters(query.toLowerCase(), selectedCategory.value);
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters(searchController.text.toLowerCase(), category);
  }

  void _applyFilters(String query, String category) {
    final filtered = allFavorite.where((item) {
      final matchesCategory = category == "All" ||
          item.category.toLowerCase() == category.toLowerCase();
      final matchesSearch = item.title.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    filteredFavorite.assignAll(filtered);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
