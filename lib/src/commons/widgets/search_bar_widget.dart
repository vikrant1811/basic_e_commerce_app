// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/common_providers.dart';
//
// class SearchBarWidget extends ConsumerWidget {
//   const SearchBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final query = ref.watch(searchQueryProvider);
//
//     return TextField(
//       onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
//       decoration: InputDecoration(
//         hintText: 'Search products…',
//         prefixIcon: const Icon(Icons.search),
//         suffixIcon: query.isNotEmpty
//             ? IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () => ref.read(searchQueryProvider.notifier).state = '',
//         )
//             : null,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../res/colors.dart';

class SearchBarWidget extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.grey,
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.grey,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                controller.clear();
                if (onChanged != null) {
                  onChanged!('');
                }
              },
              child: const Icon(
                Icons.cancel_outlined,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

