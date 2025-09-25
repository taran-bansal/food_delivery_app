import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final String? helperText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final Color? fillColor;
  final bool filled;
  final Color? cursorColor;
  final double cursorWidth;
  final double cursorHeight;
  final Radius? cursorRadius;
  final bool showCursor;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final bool expands;
  final TextDirection? textDirection;
  final String? counterText;
  final bool? showCounter;
  final String? restorationId;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? obscuringCharacter;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final Widget? Function(BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.helperText,
    this.errorText,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.fillColor,
    this.filled = true,
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight = 20.0,
    this.cursorRadius,
    this.showCursor = true,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.focusNode,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.expands = false,
    this.textDirection,
    this.counterText,
    this.showCounter,
    this.restorationId,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.obscuringCharacter = '•', 
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.buildCounter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted ?? onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autofocus: autoFocus,
      readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      cursorColor: cursorColor ?? theme.colorScheme.primary,
      cursorWidth: cursorWidth.w,
      cursorHeight: cursorHeight.h,
      cursorRadius: cursorRadius,
      showCursor: showCursor,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      focusNode: focusNode,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      expands: expands,
      textDirection: textDirection,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      scrollController: scrollController,
      obscuringCharacter: obscuringCharacter!,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor,
      buildCounter: buildCounter,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: enabled ? theme.colorScheme.onSurface : theme.disabledColor,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.hintColor,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 24.w,
          minHeight: 24.h,
        ),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: suffixIcon,
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 24.w,
          minHeight: 24.h,
        ),
        prefixText: prefixText,
        suffixText: suffixText,
        helperText: helperText,
        errorText: errorText,
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.error,
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
        border: border ?? defaultBorder,
        enabledBorder: enabledBorder ?? border ?? defaultBorder,
        focusedBorder: focusedBorder ??
            defaultBorder.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
        errorBorder: errorBorder ??
            defaultBorder.copyWith(
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),
        disabledBorder: disabledBorder ?? border ?? defaultBorder,
        filled: filled,
        fillColor: fillColor ?? theme.colorScheme.surface,
        counterText: counterText,
        counterStyle: theme.textTheme.bodySmall,
        errorMaxLines: 2,
        helperMaxLines: 2,
      ),
    );
  }
}
