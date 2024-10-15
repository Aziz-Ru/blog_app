import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  BlogRepositoryImplementation(this.blogRemoteDatasource);

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required String title,
      required String content,
      required File image,
      required List<String> categories,
      required String userId}) async {
    try {
      BlogModel? blogModel = BlogModel(
          id: const Uuid().v1(),
          title: title,
          content: content,
          imageUrl: '',
          categories: categories,
          userId: userId);
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(
          image: image, blog: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final blog = await blogRemoteDatasource.uploadBlog(blogModel);

      return Right(blog);
      
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadBlogImage(
      {required File image, required Blog blog}) async {
    // TODO: implement uploadBlogImage
    throw UnimplementedError();
  }
}
