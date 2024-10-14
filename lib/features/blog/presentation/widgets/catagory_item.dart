import 'package:flutter/material.dart';

class CatagoriesItem extends StatelessWidget {
  final String label;
  const CatagoriesItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(label:  Text(label));
  }
}