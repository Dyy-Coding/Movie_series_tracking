import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/nav_item_profile.dart';
import 'package:movie_app/app/data/models/category_item_model.dart';
import 'package:movie_app/app/data/models/movie.dart';

class CategoryController extends GetxController {
  final List<CategoryItem> categories = navList;

  // Observable selected category
  final RxString selectedCategory = "Reviews".obs;

  // Observable filtered movie list
  final RxList<MovieItem> filteredMovies = <MovieItem>[].obs;

  // Full movie list (all movies)
  final List<MovieItem> allMovies;

  CategoryController({required this.allMovies}) {
    // initialize filteredMovies with all movies
    filteredMovies.assignAll(allMovies);
  }

  /// Call this function when a category is selected
  void onCategorySelected(String name) {
    selectedCategory.value = name;

    if (name == "Reviews") {
      filteredMovies.assignAll(allMovies); // show all movies
    } else {
      filteredMovies.assignAll(
          allMovies.where((movie) => movie.category == name).toList());
    }

    debugPrint("Selected category: $name");
  }
}
