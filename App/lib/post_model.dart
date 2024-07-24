class Post {
  final String text;
  final String? imageUrl;
  final DateTime createdAt;
  bool isLiked;

  Post(
    this.text, {
    this.imageUrl,
    this.isLiked = false,
  }) : createdAt = DateTime.now();
}
