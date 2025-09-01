import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/movie_data.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/data/models/review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailsController extends GetxController {
  final RxBool isFavorite = false.obs;
  final RxList<Review> reviews = <Review>[].obs;
  late MovieItem movie;

  @override
  void onInit() {
    super.onInit();
    // Get movie from navigation arguments
    movie = Get.arguments as MovieItem;
    // Load favorite status
    _loadFavoriteStatus();
    // Load reviews for this movie
    reviews.assignAll(reviewsData.where((review) => review.movieId == movie.id).toList());
  }

  void toggleFavorite() async {
    isFavorite.value = !isFavorite.value;
    // Persist favorite status
    await _saveFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite.value = prefs.getBool('favorite_${movie.id}') ?? false;
  }

  Future<void> _saveFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_${movie.id}', isFavorite.value);
  }
}