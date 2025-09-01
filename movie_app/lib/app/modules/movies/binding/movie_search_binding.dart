import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/data.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_search_controller.dart';

class MovieSearchBinding extends Bindings {
  @override
  void dependencies() {
    // Inject the controller and provide popularMovies as default dataset
    Get.lazyPut<MovieSearchController>(
      () => MovieSearchController(popularMovies),
    );
  }
}
