import 'package:flutter/material.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

/// =====================
/// Search Section
/// =====================
class FavoriteSearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChanged;

  const FavoriteSearchSection({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // No Obx needed here, it's just a TextField
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: TextField(
          controller: searchController,
          onChanged: onChanged,
          style: const TextStyle(color: UColors.textPrimary),
          decoration: InputDecoration(
            hintText: "Search your favorites...",
            hintStyle: const TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
            prefixIcon: const Icon(Icons.search, color: UColors.textHighlight),
            filled: true,
            fillColor: UColors.textPrimary.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: UColors.textPrimary.withOpacity(0.2)),
            ),
          ),
        ),
      ),
    );
  }
}
