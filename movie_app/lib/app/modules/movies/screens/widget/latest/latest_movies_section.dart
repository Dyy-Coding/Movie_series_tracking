import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/movies/controllers/latest_movies_controller.dart';
import 'package:movie_app/app/utils/constants/colors.dart';
import 'package:movie_app/app/modules/movies/screens/widget/latest/latest_movie_card.dart';

class LatestMoviesSection extends StatelessWidget {
  final LatestMoviesController controller;
  final VoidCallback? onSeeAll;

  const LatestMoviesSection({
    super.key,
    required this.controller,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.latestMovies.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
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
          _LatestHeader(onSeeAll: onSeeAll),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.latestMovies.length,
              padding: const EdgeInsets.only(left: 8),
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final movie = controller.latestMovies[index];
                return LatestMovieCard(movie: movie);
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

class _LatestHeader extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const _LatestHeader({this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "🔥 Latest Movies",
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
