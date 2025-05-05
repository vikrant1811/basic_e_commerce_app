import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:basic_e_commerce_app/src/models/product_model.dart';
import 'package:basic_e_commerce_app/src/core/services/api_service.dart';

import '../../models/user_model.dart';


/// Completes after a 3‑second delay.
final splashProvider = FutureProvider.autoDispose<void>((ref) async {
  await Future.delayed(const Duration(seconds: 3));
});

/// Provides an async list of products fetched from the API.
final productProvider = FutureProvider<List<ProductModel>>((ref) async {
  final api = ApiService();
  return api.fetchProducts();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

final authTokenProvider = StateProvider<String?>((ref) => null);
final currentUserProvider = StateProvider<User?>((ref) => null);
//final statusProvider = StateProvider<Status?>((ref) => null);
final warehouseSwitchProvider = StateProvider<bool>((ref) => false);
//final selectedAvatarFileProvider = StateProvider<File?>((ref) => null);


