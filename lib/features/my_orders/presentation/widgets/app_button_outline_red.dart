import 'package:flutter/material.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_loading.dart';

class AppButtonOutlineRed extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;
  final Color borderColor;
  final Color titleColor;
  final double width;
  final double height;
  final double marginHorizontal;
  final Widget? iconChild;
  const AppButtonOutlineRed({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.borderColor = AppColors.primaryL,
    this.titleColor = AppColors.primaryL,
    this.width = 400,
    this.height = 45,
    this.marginHorizontal = 0,
    this.iconChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.red, AppColors.red]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            //side: const BorderSide(width: 2.0, color: Colors.blue),
            backgroundColor: AppColors.white,
            padding: const EdgeInsets.all(0),
          ),
          onPressed: loading ? null : onPressed,
          child: loading
              ? const AppLoading(
                  scale: 0.5,
                  color: AppColors.primaryL,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconChild == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(5),
                            child: iconChild!,
                          ),
                    Text(
                      title,
                      style: AppTextStyle.textStyleSemiBoldRed,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
