import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/movie_show/movie_card.dart';

/// =====================
/// Movie Grid Section
/// =====================
class MovieShow extends StatelessWidget {
  final RxList<MovieItem> movies;

  const MovieShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    // Obx inside handles updates to the list only
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => MovieCard(movie: movies[index]),
            childCount: movies.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
        ),
      ),
    );
  }
}