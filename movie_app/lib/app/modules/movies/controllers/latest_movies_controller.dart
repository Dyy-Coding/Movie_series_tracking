import 'package:movie_app/app/data/models/movie.dart';

class LatestMoviesController {
  final List<MovieItem> latestMovies;

  LatestMoviesController({required this.latestMovies});

  bool get isEmpty => latestMovies.isEmpty;
}
