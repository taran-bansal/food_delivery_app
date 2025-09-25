import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderWidth;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.width,
    this.height = 48,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.borderRadius = 12,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonWidth = isFullWidth ? double.infinity : width;
    
    return SizedBox(
      width: buttonWidth,
      height: height?.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: textColor ?? theme.colorScheme.primary,
          side: BorderSide(
            color: borderColor ?? theme.colorScheme.primary,
            width: (borderWidth ?? 1.0).w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          padding: padding ?? EdgeInsets.zero,
          disabledBackgroundColor: (backgroundColor ?? Colors.transparent).withOpacity(0.3),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  color: textColor ?? theme.colorScheme.primary,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: textColor ?? theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: 8.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
