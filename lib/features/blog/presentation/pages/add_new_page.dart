import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedCatagories = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();

    setState(() {
      image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Blog'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  selectedCatagories.isNotEmpty &&
                  image != null) {
                final userId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user
                        .id;

                context.read<BlogBloc>().add(BlogUpload(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    image: image!,
                    categories: selectedCatagories,
                    userId: userId));
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: selectImage,
                      child: image != null
                          ? SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : DottedBorder(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _buildCatagories(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(controller: titleController, hintText: 'Title'),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                        controller: contentController, hintText: 'Content')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCatagories() {
    return catagories
        .map((e) => GestureDetector(
              onTap: () {
                if (selectedCatagories.contains(e)) {
                  selectedCatagories.remove(e);
                  setState(() {});
                  return;
                } else {
                  selectedCatagories.add(e);
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Chip(
                  color: selectedCatagories.contains(e)
                      ? const WidgetStatePropertyAll(AppPallete.gradient1)
                      : const WidgetStatePropertyAll(null),
                  label: Text(e),
                  side: const BorderSide(color: AppPallete.borderColor),
                ),
              ),
            ))
        .toList();
  }
}
