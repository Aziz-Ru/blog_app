class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> catagories;
  final String userId;
  final DateTime createdAt;
  final String? username;

  Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.catagories,
      required this.userId,
      required this.createdAt,
      this.username});
}
