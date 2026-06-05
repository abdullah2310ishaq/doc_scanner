// import 'package:flutter/material.dart';

// import '../../../core/theme/app_colors.dart';

// class HomeSearchBar extends StatelessWidget {
//   const HomeSearchBar({
//     super.key,
//     required this.hint,
//     this.onChanged,
//     this.onSubmitted,
//   });

//   final String hint;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onSubmitted;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: onChanged,
//       onSubmitted: onSubmitted,
//       textInputAction: TextInputAction.search,
//       style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(
//           color: AppColors.textSecondary,
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//         ),
//         prefixIcon: const Icon(
//           Icons.search_rounded,
//           color: AppColors.textSecondary,
//           size: 22,
//         ),
//         filled: true,
//         fillColor: AppColors.searchFill,
//         contentPadding: const EdgeInsets.symmetric(vertical: 14),
//         border: _border(),
//         enabledBorder: _border(),
//         focusedBorder: _border(focused: true),
//       ),
//     );
//   }

//   OutlineInputBorder _border({bool focused = false}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppColors.searchRadius),
//       borderSide: BorderSide(
//         color: focused ? AppColors.textLink : AppColors.searchBorder,
//         width: focused ? 1.5 : 1,
//       ),
//     );
//   }
// }
