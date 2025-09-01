import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class SearchItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const SearchItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: imageUrl.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: UColors.sectionBackground,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: UColors.textHighlight,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: UColors.sectionBackground,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: UColors.textSecondary,
                          ),
                        ),
                      )
                    : Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: UColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
