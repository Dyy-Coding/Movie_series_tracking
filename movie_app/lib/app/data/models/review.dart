class Review {
  final int id;
  final int movieId;
  final double rating;
  final String comment;
  final String user;

  Review({
    required this.id,
    required this.movieId,
    required this.rating,
    required this.comment,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['id'],
        movieId: json['movie_id'],
        rating: (json['rating'] ?? 0).toDouble(),
        comment: json['comment'],
        user: json['user'],
      );
}