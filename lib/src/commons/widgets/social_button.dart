import 'package:flutter/material.dart';
import '../../res/colors.dart';

class SocialButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const SocialButton({super.key, required this.assetPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            assetPath,
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }
}
