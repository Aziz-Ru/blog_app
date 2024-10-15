import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.catagories,
      required super.userId,
      required super.createdAt,
      super.username});

  // this is json deserialization
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      catagories: List<String>.from(json['catagories'] ?? []),
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  // this is json serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'catagories': catagories,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? catagories,
    String? userId,
    DateTime? createdAt,
    String? username,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      catagories: catagories ?? this.catagories,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      username: username ?? this.username,
    );
  }
}
