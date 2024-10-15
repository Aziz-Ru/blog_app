import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.categories,
    required super.userId,
  });

  // this is json deserialization
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      categories: List<String>.from(json['categories']),
      userId: json['user_id'],
    );
  }
  // this is json serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'categories': categories,
      'user_id': userId,
    };
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? categories,
    String? userId,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
      userId: userId ?? this.userId,
    );
  }
}
