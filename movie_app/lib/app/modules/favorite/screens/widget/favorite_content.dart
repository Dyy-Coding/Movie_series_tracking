import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:movie_app/app/modules/favorite/screens/widget/favorite_search_section.dart';
import 'package:movie_app/app/modules/favorite/screens/widget/movie_show/movie_show.dart';

/// =====================
/// Favorite Content (Main Slivers)
/// =====================
class FavoriteContent extends StatelessWidget {
  final FavoriteController controller;

  const FavoriteContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search input (plain, no Obx)
        FavoriteSearchSection(
          searchController: controller.searchController,
          onChanged: controller.filterBySearch,
        ),

        // Movie grid (Obx inside)
        MovieShow(movies: controller.filteredFavorite),

        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
