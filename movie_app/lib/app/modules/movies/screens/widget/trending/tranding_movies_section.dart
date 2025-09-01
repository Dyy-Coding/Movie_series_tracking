import 'package:flutter/material.dart';
import 'package:movie_app/app/utils/constants/colors.dart';
import 'package:movie_app/app/modules/movies/controllers/trending_movies_controller.dart';
import 'trending_movie_card.dart';

class TrendingMoviesSection extends StatelessWidget {
  final TrendingMoviesController controller;
  final VoidCallback? onSeeAll;

  const TrendingMoviesSection({
    super.key,
    required this.controller,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.trendingMovies.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            "No trending movies available.",
            style: TextStyle(color: Color.fromARGB(137, 255, 255, 255)),
          ),
        ),
      );
    }

    return Container(
      color: UColors.scaffoldBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TrendingHeader(onSeeAll: onSeeAll),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingMovies.length,
              padding: const EdgeInsets.only(left: 8),
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final movie = controller.trendingMovies[index];
                return TrendingMovieCard(movie: movie);
              },
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: UColors.dividerColor, thickness: 1),
        ],
      ),
    );
  }
}

class _TrendingHeader extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const _TrendingHeader({this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "🔥 Trending Now",
          style: TextStyle(
            color: UColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(
                color: UColors.textHighlight,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
