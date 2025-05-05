import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String routeName = 'cart';
  static const routePath = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Cart Screen'));
  }
}
