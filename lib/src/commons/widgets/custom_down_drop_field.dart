import 'package:flutter/material.dart';
import '../../res/colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;
  final Color? dropdownColor;
  final bool isExpanded;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = true,
    this.dropdownColor,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: onChanged,
          isDense: isDense,
          isExpanded: isExpanded,
          dropdownColor: dropdownColor,
          decoration: InputDecoration(
            hintText: 'Select $label',
            hintStyle: const TextStyle(color: AppColors.grey),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.grey, ),
    ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.theme),
            ),
          ),
        ),
      ],
    );
  }
}
