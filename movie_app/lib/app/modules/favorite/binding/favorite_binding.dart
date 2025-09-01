import 'package:get/get.dart';
import 'package:movie_app/app/modules/favorite/controllers/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Put the FavoriteController
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
