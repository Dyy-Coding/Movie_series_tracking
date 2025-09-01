import 'package:movie_app/app/data/datasources/review_data.dart';
import 'package:movie_app/app/modules/profiles/controllers/category_controller.dart';

class CategoryBinding {
  static CategoryController bind() {
    // Pass allMovies to the controller
    return CategoryController(allMovies: allMovies);
  }
}
