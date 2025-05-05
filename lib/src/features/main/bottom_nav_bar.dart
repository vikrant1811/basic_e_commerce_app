import 'package:basic_e_commerce_app/src/features/favorites/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../home/home_screen.dart';
import '../category/category_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/views/profile_screen.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine the selected tab index based on the current route path
    final location = GoRouterState.of(context).uri.path;
    int currentIndex;
    if (location.startsWith(HomeScreen.routePath)) {
      currentIndex = 0;
    } else if (location.startsWith(CategoryScreen.routePath)) {
      currentIndex = 1;
    } else if (location.startsWith(CartScreen.routePath)) {
      currentIndex = 2;
    } else if (location.startsWith(FavoritesScreen.routePath)) {
      currentIndex = 3;
    } else if (location.startsWith(ProfileScreen.routePath)) {
      currentIndex = 4;
    }
    else {
      currentIndex = 0;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Navigate to the appropriate route when tapped
        switch (index) {
          case 0:
            context.go(HomeScreen.routePath);
            break;
          case 1:
            context.go(CategoryScreen.routePath);
            break;
          case 2:
            context.go(CartScreen.routePath);
            break;
          case 3:
            context.go(FavoritesScreen.routePath);
            break;
          case 4:
            context.go(ProfileScreen.routePath);
            break;
        }
      },
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}