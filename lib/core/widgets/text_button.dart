import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? iconSpacing;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: textColor ?? theme.colorScheme.primary,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w600,
      decoration: decoration,
    );

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor ?? theme.colorScheme.primary,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: (iconSpacing ?? 8).w),
                ],
                Text(
                  text,
                  style: defaultTextStyle,
                ),
                if (suffixIcon != null) ...[
                  SizedBox(width: (iconSpacing ?? 8).w),
                  suffixIcon!,
                ],
              ],
            ),
    );
  }
}
