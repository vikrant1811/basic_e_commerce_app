import 'package:flutter/material.dart';

import '../../res/colors.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String routePath;

  MenuItem(this.icon, this.title, this.routePath);
}

class CustomMenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback? onTap;
  final Widget? trailingWidget;

  const CustomMenuItemTile({
    super.key,
    required this.menuItem,
    this.onTap,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          leading: Icon(menuItem.icon, color: AppColors.black),
          title: Text(
            menuItem.title,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
          ),
          trailing: trailingWidget,
          onTap: onTap,
        ),
      ),
    );
  }
}
