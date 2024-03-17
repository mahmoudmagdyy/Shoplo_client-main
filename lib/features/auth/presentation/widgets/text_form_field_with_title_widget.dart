

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';


class TextFormFieldWithTitleWidget extends StatelessWidget {
  const TextFormFieldWithTitleWidget({
    super.key,
    required this.title,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization,
    this.autofocus,
    this.obscureText,
    this.suffix,
    this.prefix,
    this.enabled,
    this.hint,
    this.validator,
    this.filled,
    this.fillColor,
    this.onFieldSubmitted,
    this.errorWidget,
    this.inputFormatters,
    this.textColor,
    this.maxLines = 1,
  });
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final void Function(String)? onFieldSubmitted;
  final Widget? errorWidget;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.textStyleMediumGray2
        ),
        SizedBox(height: 10,),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          autofocus: autofocus ?? false,
          enabled: enabled ?? true,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          validator: validator,
          inputFormatters: inputFormatters,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: filled,

            fillColor: fillColor ?? AppColors.borderGrey,
            iconColor:AppColors.borderGrey,
            prefixIconColor:AppColors.borderGrey,
            suffixIconColor: AppColors.borderGrey,

            prefixIcon: prefix,

            suffixIcon: suffix,
            // suffix: suffix,
            hintText: hint,
            hintStyle:AppTextStyle.textStyleBoldBlack
          ),
        ),
        errorWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
