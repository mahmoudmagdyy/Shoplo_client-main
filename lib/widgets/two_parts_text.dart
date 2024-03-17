import 'package:flutter/material.dart';

import '../resources/styles/app_text_style.dart';

class TwoPartText extends StatelessWidget {
  const TwoPartText({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title : ",
          style: AppTextStyle.textStyleBoldBlack,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            style: AppTextStyle.textStyleMediumGray,
          ),
        ),
      ],
    );
  }
}
