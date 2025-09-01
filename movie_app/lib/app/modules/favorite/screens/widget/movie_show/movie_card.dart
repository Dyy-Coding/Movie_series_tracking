import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

/// Individual movie card
class MovieCard extends StatelessWidget {
  final MovieItem movie;
 MovieCard({super.key, required this.movie});

  /// Reactive favorite state
  final RxBool isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    // Fallbacks for null values
    final posterUrl = (movie.posterImage != null && movie.posterImage!.isNotEmpty)
        ? movie.posterImage!
        : 'assets/images/placeholder.png';
    final title = movie.title ;
    final status = movie.status;
    final averageRating = movie.averageRating;
    final seasons = movie.seasons ;
    final episodes = movie.episodes;

    return GestureDetector(
      onTap: () => Get.toNamed("/movie_detail", arguments: movie),
      child: Container(
        decoration: BoxDecoration(
          color: UColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: UColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Poster
              Positioned.fill(
                child: posterUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: posterUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: UColors.sectionBackground),
                        errorWidget: (context, url, error) => Container(
                          color: UColors.sectionBackground,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: UColors.textSecondary,
                            size: 50,
                          ),
                        ),
                      )
                    : Image.asset(posterUrl, fit: BoxFit.cover),
              ),

              // Gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Status badge
              if (status.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Details icon
              Positioned(
                top: status.isNotEmpty ? 40 : 8,
                right: 8,
                child: Tooltip(
                  message: 'View Details',
                  child: GestureDetector(
                    onTap: () => Get.toNamed("/movie_detail", arguments: movie),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // Favorite toggle
              Positioned(
                top: 8,
                left: 8,
                child: Obx(
                  () => GestureDetector(
                    onTap: () => isFavorite.value = !isFavorite.value, // toggle
                    child: Icon(
                      !isFavorite.value ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite.value ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 0, 0),
                      size: 24,
                    ),
                  ),
                ),
              ),


              // Rating badge
              Positioned(
                top: 40,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Movie info
              Positioned(
                bottom: 12,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: UColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Season $seasons | $episodes episodes",
                      style: const TextStyle(
                        fontSize: 12,
                        color: UColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}