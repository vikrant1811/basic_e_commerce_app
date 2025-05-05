import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = 'favorites';
  static const routePath = '/favorites';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favorites Screen'));
  }
}
