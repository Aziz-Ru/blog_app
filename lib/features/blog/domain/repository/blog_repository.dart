import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required File image,
    required List<String> categories,
    required String userId,
  });

  Future<Either<Failure, String>> uploadBlogImage(
      {required File image, required Blog blog});
}
