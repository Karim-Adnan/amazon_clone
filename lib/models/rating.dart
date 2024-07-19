class Rating {
  final String userId;
  final double rating;

  Rating({
    required this.userId,
    required this.rating,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'],
      rating: double.parse(map['rating'].toString()),
    );
  }
}
