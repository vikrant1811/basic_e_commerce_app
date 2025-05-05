import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../res/colors.dart';

class ReusableBackButton extends StatelessWidget {
  final IconData icon;

  const ReusableBackButton({
    super.key,
    this.icon = Icons.arrow_back,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.theme,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: AppColors.white,
            size: 18.0,
          ),
        ),
      ),
    );
  }
}
