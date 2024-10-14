import 'package:blog_app/features/blog/presentation/pages/add_new_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog Cutter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlog.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: const Center(
        child: Text('Blog Page'),
      ),
    );
  }
}
