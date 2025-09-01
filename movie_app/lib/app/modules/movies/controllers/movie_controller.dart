import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/app/data/models/movie.dart';

class MovieController {
  final MovieItem model;
  final PageController pageController;
  late Timer _autoScrollTimer;
  int currentPage;

  MovieController(this.model, {int initialPageMultiplier = 0})
      : currentPage = initialPageMultiplier > 0 ? initialPageMultiplier * 1000 : 0,
        pageController = PageController(
          viewportFraction: 0.8,
          initialPage: initialPageMultiplier > 0 ? initialPageMultiplier * 1000 : 0,
        );

  void startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (pageController.hasClients) {
        currentPage++;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void dispose() {
    _autoScrollTimer.cancel();
    pageController.dispose();
  }

  // ====================
  // Null-safe accessors
  // ====================

  String get title => model.title;
  String get description => model.description ?? "No description available";
  String get releaseDate => model.releaseDate ?? "Unknown";
  String get posterImage => model.posterImage ?? "";
  String get backdropImage => model.backdropImage ?? "";
  String get type => model.type;
  int get duration => model.duration;
  int get seasons => model.seasons;
  int get episodes => model.episodes;
  String get director => model.director ?? "Unknown";
  List<String> get cast => model.cast ?? [];
  int get tmdbId => model.tmdbId;
  double get averageRating => model.averageRating;
  int get voteCount => model.voteCount;
  String get category => model.category;
  String get status => model.status;
}
