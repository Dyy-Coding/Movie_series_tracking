import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/data/models/review.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_detail_controller.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieDetailsController>();
    final MovieItem movie = controller.movie;

    // Fallback for posterImage
    final imageUrl = (movie.posterImage != null && movie.posterImage!.isNotEmpty)
        ? movie.posterImage!
        : 'assets/images/placeholder.png';

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: CustomScrollView(
        slivers: [
          // AppBar with gradient
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: UColors.textPrimary,
                      shadows: const [
                        Shadow(offset: Offset(1, 1), blurRadius: 6, color: Colors.black),
                      ],
                    ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  imageUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: UColors.sectionBackground,
                            child: const Center(child: CircularProgressIndicator(color: UColors.textHighlight)),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: UColors.sectionBackground,
                            child: const Icon(Icons.broken_image, color: UColors.textSecondary, size: 50),
                          ),
                        )
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: const Color(0xFF6A0DAD),
            foregroundColor: Colors.white,
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                      controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                      color: UColors.favoriteIcon,
                    ),
                    onPressed: controller.toggleFavorite,
                  )),
            ],
          ),
          // Movie Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating
                  Row(
                    children: [
                      Text(
                        '${(movie.averageRating / 2).toStringAsFixed(1)}/5',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: UColors.textPrimary),
                      ),
                      const SizedBox(width: 8),
                      for (int i = 0; i < (movie.averageRating / 2).floor(); i++)
                        const Icon(Icons.star, color: UColors.ratingStar, size: 18),
                      for (int i = 0; i < (5 - (movie.averageRating / 2).floor()); i++)
                        const Icon(Icons.star_border, color: UColors.ratingStar, size: 18),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: UColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.description ?? 'No description available.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  // Details
                  _buildDetailRow(context, 'Director', movie.director ?? 'N/A'),
                  _buildDetailRow(context, 'Cast', movie.cast?.join(', ') ?? 'N/A'),
                  _buildDetailRow(context, 'Duration', '${movie.duration} min'),
                  _buildDetailRow(context, 'Release Date', movie.releaseDate ?? 'N/A'),
                  _buildDetailRow(context, 'Category', movie.category),
                  const SizedBox(height: 16),
                  // Reviews
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: UColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => controller.reviews.isEmpty
                      ? Text(
                          'No reviews available.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
                        )
                      : Column(
                          children: controller.reviews.map((review) => _buildReviewCard(context, review)).toList(),
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: UColors.textPrimary, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Card(
      color: const Color(0xFF2A2A4E),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  review.user,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: UColors.textPrimary),
                ),
                const Spacer(),
                Text(
                  '${review.rating}/5',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UColors.ratingStar),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}