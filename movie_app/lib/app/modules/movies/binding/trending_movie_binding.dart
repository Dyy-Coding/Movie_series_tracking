import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/modules/movies/controllers/trending_movies_controller.dart';

class TrendingMoviesBinding {
  static TrendingMoviesController bind(List<MovieItem> items) {
    return TrendingMoviesController(trendingMovies: items);
  }
}
