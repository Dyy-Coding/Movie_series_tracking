import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class LatestMovieCard extends StatefulWidget {
  final MovieItem movie;

  const LatestMovieCard({super.key, required this.movie});

  @override
  State<LatestMovieCard> createState() => _LatestMovieCardState();
}

class _LatestMovieCardState extends State<LatestMovieCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Provide a non-nullable fallback for posterImage
    final imageUrl = (widget.movie.posterImage != null && widget.movie.posterImage!.isNotEmpty)
        ? widget.movie.posterImage!
        : 'assets/images/placeholder.png';

    // Provide a non-nullable fallback for title
    final title = widget.movie.title;

    int fullStars = ((widget.movie.averageRating) / 2).floor(); // rating out of 10 → 5 stars
    int emptyStars = 5 - fullStars;

    return SizedBox(
      width: 180,
      child: GestureDetector(
        onTap: () => Get.toNamed("/movie_detail", arguments: widget.movie),
        child: Container(
          decoration: BoxDecoration(
            color: UColors.cardBackground,
            borderRadius: BorderRadius.circular(24),
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
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Movie Poster
                Positioned.fill(
                  child: imageUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: UColors.sectionBackground,
                            child: const Center(
                              child: CircularProgressIndicator(color: UColors.textHighlight),
                            ),
                          ),
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
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                ),

                // Gradient overlay
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

                // Favorite icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => setState(() => isFavorite = !isFavorite),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: UColors.favoriteIcon,
                      size: 26,
                    ),
                  ),
                ),

                // Movie info
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
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
                          fontSize: 18,
                          shadows: [
                            Shadow(offset: Offset(1, 1), blurRadius: 6, color: Colors.black),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          for (int i = 0; i < fullStars; i++)
                            const Icon(Icons.star, color: UColors.ratingStar, size: 18),
                          for (int i = 0; i < emptyStars; i++)
                            const Icon(Icons.star_border, color: UColors.ratingStar, size: 18),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              color: Color(0xFF6A0DAD),
                              size: 24,
                            ),
                            onPressed: () => Get.toNamed("/movie_detail", arguments: widget.movie),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}