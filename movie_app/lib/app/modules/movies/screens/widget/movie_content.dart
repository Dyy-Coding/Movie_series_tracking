import 'package:flutter/material.dart';
import 'package:movie_app/app/data/datasources/data.dart';
import 'package:movie_app/app/data/datasources/latest_movie_data.dart';
import 'package:movie_app/app/modules/movies/binding/latest_binding.dart';
import 'package:movie_app/app/modules/movies/binding/trending_movie_binding.dart';
import 'package:movie_app/app/modules/movies/screens/widget/popular/popular_section.dart';
import 'package:movie_app/app/modules/movies/screens/widget/search/search_sections.dart';
import 'package:movie_app/app/modules/movies/screens/widget/trending/tranding_movies_section.dart';
import 'package:movie_app/app/modules/movies/screens/widget/latest/latest_movies_section.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Bind trending movies
    final trendingController = TrendingMoviesBinding.bind(popularMovies);

    // ✅ Bind latest movies
    final latestController = LatestMoviesBinding.bind(latestMovies);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ✅ Search section
          SearchSection(),

          /// ✅ Popular movies section
          PopularSection(items: popularMovies,),

          /// ✅ Latest movies section
          LatestMoviesSection(controller: latestController),

          /// ✅ Trending movies section
          TrendingMoviesSection(controller: trendingController),

        ],
      ),
    );
  }
}
