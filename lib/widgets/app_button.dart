  import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/widgets/app_loading.dart';

import '../resources/styles/app_text_style.dart';

class AppButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final bool loading;
  final double? width;
  final double? height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final String title;
  final String? value;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.borderRadius,
    this.width,
    this.height ,
    this.gradient = const LinearGradient(
      colors: [
        AppColors.gradientButton_1,
        AppColors.gradientButton_2,
        // AppColors.gradientButton_3
      ],
      begin: Alignment(0, 0),
      end: Alignment(1, 1),
    ),
    this.loading = false,
    this.value = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(15);
    return Container(
      width: width ?? context.width * 0.9,
      height: height  ?? context.height *0.07,
      decoration: BoxDecoration(
        color: AppColors.secondaryL,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          //shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: loading
            ? const AppLoading(
                scale: 0.5,
              )
            : Row(
                mainAxisAlignment: value!.isNotEmpty
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.textStyleButton,
                  ),
                  if (value!.isNotEmpty)
                    Expanded(
                      child: Container(),
                    ),
                  if (value!.isNotEmpty)
                    Text(
                      value!,
                      style: AppTextStyle.textStyleButton,
                    ),
                ],
              ),
      ),
    );
  }
}
