import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../res/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  static String routeName = 'productDetails';
  static const routePath = '/product/:id';
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title,style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: AppColors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price}',
                style: TextStyle(fontSize: 20, color: AppColors.green),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
