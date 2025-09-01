import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/data.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_controller.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_search_controller.dart';

/// Factory helper for creating MovieController
class MovieFactory {
  /// Bind a MovieController from explicit parameters
  static MovieController bind({
    required int id,
    required String title,
    String description = "",
    String releaseDate = "",
    String posterImage = "",
    String backdropImage = "",
    String type = "Movie",
    int duration = 0,
    int seasons = 1,
    int episodes = 1,
    String director = "",
    List<String> cast = const [],
    int tmdbId = 0,
    double averageRating = 0.0,
    int voteCount = 0,
    String category = "",
    String status = "Released",
    int initialPageMultiplier = 0,
  }) {
    final model = MovieItem(
      id: id,
      title: title,
      description: description,
      releaseDate: releaseDate,
      posterImage: posterImage,
      backdropImage: backdropImage,
      type: type,
      duration: duration,
      seasons: seasons,
      episodes: episodes,
      director: director,
      cast: cast,
      tmdbId: tmdbId,
      averageRating: averageRating,
      voteCount: voteCount,
      category: category,
      status: status,
    );
    return MovieController(model, initialPageMultiplier: initialPageMultiplier);
  }

  /// Bind a MovieController from a JSON map
  static MovieController fromJson(
    Map<String, dynamic> json, {
    int initialPageMultiplier = 0,
  }) {
    final model = MovieItem.fromJson(json);
    return MovieController(model, initialPageMultiplier: initialPageMultiplier);
  }
}

/// Proper GetX Binding for Movie features
class MovieBinding extends Bindings {
  @override
  void dependencies() {
    // Inject MovieSearchController globally for movies module
    Get.lazyPut<MovieSearchController>(
      () => MovieSearchController(popularMovies),
    );
  }
}
