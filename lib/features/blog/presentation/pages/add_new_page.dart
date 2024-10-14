import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlog());
  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Blog'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: const Center(
        child: Text('Add New Blog Page'),
      ),
    );
  }
}
