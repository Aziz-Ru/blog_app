import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required String id,
    required String title,
    required String content,
    required String imageUrl,
    required List<String> categories,
    required String userId,
  }) : super(
          id: id,
          title: title,
          content: content,
          imageUrl: imageUrl,
          categories: categories,
          userId: userId,
        );

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      categories: List<String>.from(json['categories']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'categories': categories,
      'userId': userId,
    };
  }
}
