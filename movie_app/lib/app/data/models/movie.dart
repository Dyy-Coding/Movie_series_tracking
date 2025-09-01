class MovieItem {
  final int id;
  final String title;
  final String? description;
  final String? releaseDate;
  final String? posterImage; // <- nullable
  final String? backdropImage;
  final String type;
  final int duration;
  final int seasons;
  final int episodes;
  final String? director;
  final List<String>? cast;
  final int tmdbId;
  final double averageRating;
  final int voteCount;
  final String category;
  final String status;

  MovieItem({
    required this.id,
    required this.title,
    this.description,
    this.releaseDate,
    this.posterImage,
    this.backdropImage,
    required this.type,
    required this.duration,
    required this.seasons,
    required this.episodes,
    this.director,
    this.cast,
    required this.tmdbId,
    required this.averageRating,
    required this.voteCount,
    required this.category,
    required this.status,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) => MovieItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        releaseDate: json['release_date'],
        posterImage: json['poster_image'],
        backdropImage: json['backdrop_image'],
        type: json['type'],
        duration: json['duration'],
        seasons: json['seasons'],
        episodes: json['episodes'],
        director: json['director'],
        cast: List<String>.from(json['cast'] ?? []),
        tmdbId: json['tmdb_id'],
        averageRating: (json['average_rating'] ?? 0).toDouble(),
        voteCount: json['vote_count'] ?? 0,
        category: json['category'],
        status: json['status'],
      );
}
