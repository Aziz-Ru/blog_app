import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlog());
  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final catagories = [
    'Technology',
    'Health',
    'Fashion',
    'Food',
    'Travel',
    'Sports',
    'Entertainment',
    'Education',
    'Business',
    'Science',
    'Politics',
    'Lifestyle',
    'Others'
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: const [10, 5],
                radius: const Radius.circular(12),
                borderType: BorderType.RRect,
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select Image',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildCatagories(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCatagories() {
    return catagories
        .map((e) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(e),
                side: const BorderSide(color: AppPallete.borderColor),
              ),
            ))
        .toList();
  }
}
