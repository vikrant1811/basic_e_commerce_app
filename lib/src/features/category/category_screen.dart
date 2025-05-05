import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = 'category';
  static const routePath = '/category';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Category Screen'));
  }
}
