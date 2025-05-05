import 'package:basic_e_commerce_app/src/commons/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../commons/providers/common_providers.dart';
import '../../res/colors.dart';
import '../product/widgets/product_card.dart';

class HomeScreen extends ConsumerWidget {
  static String routeName = 'home';
  static const routePath = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);
    final query = ref.watch(searchQueryProvider).toLowerCase();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.grey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 12),
              Expanded(
                child: productsAsync.when(
                  data: (products) {
                    // apply filtering
                    final filtered = query.isEmpty
                        ? products
                        : products
                        .where((p) => p.title.toLowerCase().contains(query))
                        .toList();

                    if (filtered.isEmpty) {
                      return const Center(child: Text('No products found.'));
                    }

                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filtered[index]);
                      },
                    );
                  },
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (err, _) =>
                      Center(child: Text('Failed to load: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
