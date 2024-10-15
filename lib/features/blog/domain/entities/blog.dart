class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> categories;
  final String userId;

  Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.categories,
      required this.userId});
}
