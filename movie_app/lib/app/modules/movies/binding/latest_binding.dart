import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/modules/movies/controllers/latest_movies_controller.dart';

class LatestMoviesBinding {
  static LatestMoviesController bind(List<MovieItem> items) {
    return LatestMoviesController(latestMovies: items);
  }
}
