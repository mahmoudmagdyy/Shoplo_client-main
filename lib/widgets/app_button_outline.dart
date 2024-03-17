import 'package:flutter/material.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../resources/colors/colors.dart';
import 'app_loading.dart';

class AppButtonOutline extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;
  final Color borderColor;
  final Color titleColor;
  final double width;
  final double height;
  final double marginHorizontal;
  final Widget? iconChild;
  const AppButtonOutline({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.borderColor = AppColors.primaryL,
    this.titleColor = AppColors.primaryL,
    this.width = 400,
    this.height = 50,
    this.marginHorizontal = 0,
    this.iconChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
       color: AppColors.primaryL,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.all(5.5),
        height: height,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
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
                    if (iconChild != null) iconChild!,
                    if (iconChild != null) const SizedBox(width: 5),
                    Text(
                      title,
                      style: AppTextStyle.textStylePrimaryColorSemiBold,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
