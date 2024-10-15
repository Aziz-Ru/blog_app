import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<String> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImplementation extends BlogRemoteDatasource {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImplementation(this.supabaseClient);

  @override
  Future<String> uploadBlog(BlogModel blog) async {
    try {
      await supabaseClient.from('blogs').insert(blog.toJson());
      return 'success';
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      // print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response =
          await supabaseClient.from('blogs').select('*,profiles(name)');
      if (response.isEmpty || response == null) {
        throw const ServerException('No data found');
      }
      // print(response);
      return response
          .map((e ) =>
              BlogModel.fromJson(e).copyWith(username: e['profiles']['name']))
          .toList();
    } catch (e) {
      print('getAllBlogs Error: $e');
      throw ServerException(e.toString());
    }
  }
}
