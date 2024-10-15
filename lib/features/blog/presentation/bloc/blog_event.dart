part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent{
  final String title;
  final String content;
  final File image;
  final List<String> categories;
  final String userId;

  BlogUpload({
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
    required this.userId,
  });
}