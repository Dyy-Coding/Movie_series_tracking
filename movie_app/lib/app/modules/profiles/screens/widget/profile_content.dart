import 'package:flutter/material.dart';
import 'package:movie_app/app/modules/profiles/controllers/profile_controller.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/category_section.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/information_profile.dart';
import 'package:movie_app/app/modules/profiles/screens/widget/movie_show/movie_show.dart';

/// =====================
/// Series Content (Main Slivers)
/// =====================
class ProfileContent extends StatelessWidget {
  final ProfileController controller;

  const ProfileContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: InformationProfile()),

        // Category menu
        SliverToBoxAdapter(
          child: CategoryMenuSection(
            onCategoryTap: controller.filterByCategory,
            selectedCategory: controller.selectedCategory,
          ),
        ),

        // Movie grid (already a Sliver widget?)
        MovieShow(movies: controller.filteredSeries),

        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
