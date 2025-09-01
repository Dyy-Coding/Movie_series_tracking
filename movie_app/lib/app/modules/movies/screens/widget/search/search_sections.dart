import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_search_controller.dart';
import 'package:movie_app/app/modules/movies/screens/widget/search/search_item.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieSearchController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔍 Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller.textController,
            style: const TextStyle(color: UColors.textPrimary),
            decoration: InputDecoration(
              hintText: "Search movies...",
              hintStyle: const TextStyle(color: Color.fromARGB(137, 255, 255, 255)),
              prefixIcon: const Icon(Icons.search, color: UColors.textHighlight),
              filled: true,
              fillColor: UColors.textPrimary.withAlpha((0.1 * 255).toInt()),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: UColors.textPrimary.withAlpha((0.2 * 255).toInt()),
                ),
              ),
              suffixIcon: Obx(() {
                return controller.query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: UColors.textHighlight),
                        onPressed: () {
                          controller.textController.clear();
                          controller.search('');
                        },
                      )
                    : const SizedBox.shrink();
              }),
            ),
            onChanged: controller.search,
          ),
        ),
        const SizedBox(height: 20),

        // 🎬 Search Results (only show if user typed)
        Obx(() {
          if (controller.query.isEmpty) return const SizedBox.shrink();

          final items = controller.movies;

          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "No results found",
                style: TextStyle(color: UColors.textSecondary),
              ),
            );
          }

          return SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                final imageUrl = item.posterImage?.isNotEmpty == true
                    ? item.posterImage!
                    : 'assets/images/placeholder.png';

                return SearchItem(
                  imageUrl: imageUrl,
                  title: item.title,
                  onTap: () => debugPrint("Tapped on ${item.title}"),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
