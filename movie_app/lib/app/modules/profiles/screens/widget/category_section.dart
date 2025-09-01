import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/data/datasources/nav_item_profile.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

/// =====================
/// Category Menu Section
/// =====================
class CategoryMenuSection extends StatelessWidget {
  final void Function(String) onCategoryTap;
  final RxString selectedCategory;

  const CategoryMenuSection({
    super.key,
    required this.onCategoryTap,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: navList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = navList[index];

          // Wrap only the part that needs to react to changes
          return Obx(
            () {
              final isSelected = selectedCategory.value == category.name;

              return GestureDetector(
                onTap: () => onCategoryTap(category.name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? UColors.textHighlight
                        : UColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: UColors.borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(category.icon, size: 22, color: UColors.textPrimary),
                      const SizedBox(width: 6),
                      Text(
                        category.name,
                        style: const TextStyle(
                          color: UColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
