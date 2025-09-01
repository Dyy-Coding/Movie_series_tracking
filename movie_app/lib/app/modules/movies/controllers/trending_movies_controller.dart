import 'package:movie_app/app/data/models/movie.dart';

class TrendingMoviesController {
  final List<MovieItem> trendingMovies;

  TrendingMoviesController({required this.trendingMovies});

  bool get isEmpty => trendingMovies.isEmpty;
}
