import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_controller.dart';
import 'package:movie_app/app/utils/constants/colors.dart';

class PopularBanner extends StatefulWidget {
  final MovieController controller;

  const PopularBanner({Key? key, required this.controller}) : super(key: key);

  @override
  _PopularBannerState createState() => _PopularBannerState();
}

class _PopularBannerState extends State<PopularBanner> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Fallback for posterImage
    final imageUrl = (widget.controller.posterImage.isNotEmpty)
        ? widget.controller.posterImage
        : 'assets/images/placeholder.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bannerWidth = constraints.maxWidth;

          return Center(
            child: SizedBox(
              width: bannerWidth,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    _buildBannerImage(imageUrl),
                    _buildGradientOverlay(),
                    _buildMovieInfo(),
                    _buildRating(),
                    _buildFavoriteIcon(),
                    _buildDetailsIcon(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBannerImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: imageUrl.startsWith('http')
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: UColors.sectionBackground,
                child: const Center(child: CircularProgressIndicator(color: UColors.textHighlight)),
              ),
              errorWidget: (context, url, error) => Container(
                color: UColors.sectionBackground,
                alignment: Alignment.center,
                child: Text(
                  widget.controller.title,
                  style: const TextStyle(
                    color: UColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.transparent, Colors.black54],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Positioned(
      left: 12,
      bottom: 12,
      right: 12,
      child: Text(
        widget.controller.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: UColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 4,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              widget.controller.averageRating.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteIcon() {
    return Positioned(
      top: 12,
      right: 12,
      child: GestureDetector(
        onTap: () {
          setState(() => isFavorite = !isFavorite);
        },
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.redAccent : Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildDetailsIcon() {
    return Positioned(
      bottom: 12,
      right: 12,
      child: IconButton(
        icon: const Icon(
          Icons.info_outline,
          color: Color(0xFF6A0DAD),
          size: 28,
        ),
        onPressed: () => Get.toNamed("/movie_detail", arguments: widget.controller.model),
      ),
    );
  }
}