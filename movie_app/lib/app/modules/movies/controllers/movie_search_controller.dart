import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/models/movie.dart';

class MovieSearchController extends GetxController {
  final TextEditingController textController = TextEditingController();

  /// Reactive movie list
  final RxList<MovieItem> movies = <MovieItem>[].obs;

  /// Current search query
  final RxString query = ''.obs;

  /// All available movies (reference)
  final List<MovieItem> allMovies;

  MovieSearchController(this.allMovies);

  /// Filter movies based on query
  void search(String keyword) {
    query.value = keyword;

    if (keyword.isEmpty) {
      movies.clear(); // hide results when empty
    } else {
      movies.assignAll(
        allMovies.where(
          (m) => m.title.toLowerCase().contains(keyword.toLowerCase()),
        ),
      );
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
