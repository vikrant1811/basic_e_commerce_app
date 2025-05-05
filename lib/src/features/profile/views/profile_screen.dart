import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../category/category_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = 'profile';
  static const routePath = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Profile Screen'),
        TextButton(onPressed: () {
          context.push(CategoryScreen.routePath);
        },
            child: Text('Go'))
      ],
    );
  }
}


