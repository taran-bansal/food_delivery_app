import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
  });

  // Display styles
  const CustomText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.2,
    this.letterSpacing = -0.5,
    this.decoration,
  })  : fontSize = 32,
        fontWeight = FontWeight.w700;

  // Heading styles
  const CustomText.h1(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.2,
    this.letterSpacing = -0.3,
    this.decoration,
  })  : fontSize = 24,
        fontWeight = FontWeight.w700;

  const CustomText.h2(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.25,
    this.letterSpacing = -0.2,
    this.decoration,
  })  : fontSize = 20,
        fontWeight = FontWeight.w600;

  // Body styles
  const CustomText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.5,
    this.letterSpacing = 0.1,
    this.decoration,
  })  : fontSize = 16,
        fontWeight = FontWeight.w400;

  const CustomText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.5,
    this.letterSpacing = 0.1,
    this.decoration,
  })  : fontSize = 14,
        fontWeight = FontWeight.w400;

  const CustomText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.5,
    this.letterSpacing = 0.2,
    this.decoration,
  })  : fontSize = 12,
        fontWeight = FontWeight.w400;

  // Button text
  const CustomText.button(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height = 1.5,
    this.letterSpacing = 0.5,
    this.decoration,
  })  : fontSize = 14,
        fontWeight = FontWeight.w600;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? theme.colorScheme.onBackground,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
