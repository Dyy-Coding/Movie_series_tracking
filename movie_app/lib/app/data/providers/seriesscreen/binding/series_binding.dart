import 'package:get/get.dart';
import 'package:movie_app/app/modules/seriesscreen/controllers/series_controller.dart';

class SeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesController>(() => SeriesController());
  }
}
