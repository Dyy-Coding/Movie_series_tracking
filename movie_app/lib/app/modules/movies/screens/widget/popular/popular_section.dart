import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/app/data/models/movie.dart';
import 'package:movie_app/app/modules/movies/controllers/movie_controller.dart';
import 'package:movie_app/app/utils/constants/colors.dart';
import 'popular_banner.dart';

class PopularSection extends StatefulWidget {
  final List<MovieItem> items;


  const PopularSection({super.key, required this.items});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.items.length * 1000;
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: _currentPage,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      height: 240,
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: UColors.scaffoldBackground,
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final realIndex = index % widget.items.length;
          final item = widget.items[realIndex];
          final controller = MovieController(item);

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 1.0;
              if (_pageController.position.haveDimensions) {
                final pageOffset = (_pageController.page ?? index) - index;
                scale = (1 - pageOffset.abs() * 0.2).clamp(0.85, 1.0);
              }

              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Transform.scale(
                    scale: scale,
                    child: PopularBanner(controller: controller),
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
