import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/app_language_option.dart';

class LanguageOptionCard extends StatelessWidget {
  const LanguageOptionCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
    this.compact = false,
  });

  final AppLanguageOption language;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final radius = compact ? 10.r : 14.r;
    final flagSize = compact ? 22.w : 30.w;
    final fontSize = compact ? 12.sp : 15.sp;
    final horizontalPadding = compact ? 8.w : 12.w;
    final verticalPadding = compact ? 6.h : 10.h;
    final gap = compact ? 6.w : 10.w;
    final checkSize = compact ? 14.sp : 18.sp;

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isSelected ? accentColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? accentColor.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: compact ? 6 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: flagSize,
              height: flagSize,
              child: language.isPng
                  ? Image.asset(language.imageAsset, fit: BoxFit.contain)
                  : SvgPicture.asset(
                      language.imageAsset,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: Text(
                language.nativeName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? accentColor : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: accentColor, size: checkSize),
          ],
        ),
      ),
    );
  }
}
