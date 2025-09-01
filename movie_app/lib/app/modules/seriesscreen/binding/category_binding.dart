import 'package:movie_app/app/data/datasources/movies_data.dart';
import 'package:movie_app/app/modules/seriesscreen/controllers/category_controller.dart';

class CategoryBinding {
  static CategoryController bind() {
    // Pass allMovies to the controller
    return CategoryController(allMovies: seriesList);
  }
}
