import 'package:flutter/material.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../resources/colors/colors.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color textColor;
  const AuthTitle(this.title, this.subtitle,
      {Key? key, this.textColor = AppColors.textBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style:AppTextStyle.textStyleSemiBoldGold18,
        ),
        SizedBox(height: 10),
        Text(
          subtitle,
          style: AppTextStyle.textStyleWhiteRegular16,
        ),
      ],
    );
  }
}
