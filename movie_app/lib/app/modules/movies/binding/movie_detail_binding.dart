import 'package:get/get.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_detail_controller.dart';

class MovieDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailsController>(() => MovieDetailsController(), fenix: true);
  }
}