import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/seriesscreen/controllers/series_controller.dart';
import 'package:movie_app/app/modules/seriesscreen/screens/widget/category_section.dart';
import 'package:movie_app/app/modules/seriesscreen/screens/widget/movie_show/movie_show.dart';
import 'package:movie_app/app/modules/seriesscreen/screens/widget/series_search_section.dart';

/// =====================
/// Series Content (Main Slivers)
/// =====================
class SeriesContent extends StatelessWidget {
  final SeriesController controller;

  const SeriesContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search input (plain, no Obx)
        SeriesSearchSection(
          searchController: controller.searchController,
          onChanged: controller.filterBySearch,
        ),

        // Category menu (Obx inside)
        SliverToBoxAdapter(
          child: CategoryMenuSection(
            onCategoryTap: controller.filterByCategory,
            selectedCategory: controller.selectedCategory,
          ),
        ),

        // Movie grid (Obx inside)
        MovieShow(movies: controller.filteredSeries),

        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
