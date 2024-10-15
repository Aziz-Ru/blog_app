import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_uploadBlogEventHandler);
    on<BlogFetchAll>(_getAllBlogsEventHandler);
  }

  void _uploadBlogEventHandler(
      BlogUpload event, Emitter<BlogState> emit) async {
    try {
      final res = await _uploadBlog(UploadBlogParams(
          title: event.title,
          content: event.content,
          image: event.image,
          categories: event.categories,
          userId: event.userId,
          createdAt: DateTime.now()));

      res.fold(
        (failure) => emit(BlogFailure(message: failure.toString())),
        (s) => emit(BlogUploadSuccess()),
      );
    } catch (e) {
      emit(BlogFailure(message: e.toString()));
    }
  }

  void _getAllBlogsEventHandler(
      BlogFetchAll event, Emitter<BlogState> emit) async {
    try {
      final res = await _getAllBlogs(NoParams());
      res.fold(
        (failure) => emit(BlogFailure(message: failure.toString())),
        (blogs) => emit(BlogDisplaySuccess(blogs)),
      );
    } catch (e) {
      emit(BlogFailure(message: e.toString()));
    }
  }
}
