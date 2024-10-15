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
  Future<Either<Failure, String>> uploadBlog(
      {required String title,
      required String content,
      required File image,
      required List<String> categories,
      required String userId,
      required DateTime createdAt}) async {
    try {
      BlogModel? blogModel = BlogModel(
          id: const Uuid().v1(),
          title: title,
          content: content,
          imageUrl: '',
          catagories: categories,
          userId: userId,
          createdAt: createdAt);
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(
          image: image, blog: blogModel);
      // print('repositoryImplementation imageurl: $imageUrl');
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final successs = await blogRemoteDatasource.uploadBlog(blogModel);

      return Right(successs);
    } on ServerException catch (e) {
      // print('repositoryImplementation: ${e.message}');
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDatasource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
