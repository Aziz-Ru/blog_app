import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<String, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, String>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      title: params.title,
      content: params.content,
      image: params.image,
      categories: params.categories,
      userId: params.userId,
      createdAt: params.createdAt,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final File image;
  final List<String> categories;
  final String userId;
  final DateTime createdAt;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.image,
    required this.categories,
    required this.userId,
    required this.createdAt,
  });
}
