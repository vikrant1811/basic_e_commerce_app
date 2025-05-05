import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bottom_nav_bar.dart';

/// MainScreen wraps child screens and keeps the BottomNavBar always visible.
class MainScreen extends ConsumerWidget {
  static const routeName = 'main';
  static const routePath = '/main';

  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,               // The active tab's content
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
