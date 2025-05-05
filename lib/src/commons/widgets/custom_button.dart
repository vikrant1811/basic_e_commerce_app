import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../res/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final String? route; // Made route optional
  final Color backgroundColor;
  final double fontSize;
  final Color textColor;
  final VoidCallback? onPressedCallback;

  const CustomButton({
    super.key,
    required this.label,
    this.route,
    this.backgroundColor = AppColors.theme,
    this.fontSize = 18,
    this.textColor = AppColors.white,
    this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (onPressedCallback != null) {
            onPressedCallback!(); // Use custom onPressed logic if provided
          } else if (route != null) {
            context.push(route!); // Default to navigation if no callback
          } else {
            throw Exception("CustomButton requires either a route or onPressedCallback.");
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
