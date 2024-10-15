import 'dart:io';

import 'package:blog_app/features/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_uploadBlog);
  }

  void _uploadBlog(BlogUpload event, Emitter<BlogState> emit) async{
    try {
      final blog = await uploadBlog(UploadBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        categories: event.categories,
        userId: event.userId,
      ));

      blog.fold(
        (failure) => emit(BlogFailure(message: failure.toString())),
        (blog) => emit(BlogSuccess()),
      );
    } catch (e) {
      emit(BlogFailure(message: e.toString()));
    }
  }
}
