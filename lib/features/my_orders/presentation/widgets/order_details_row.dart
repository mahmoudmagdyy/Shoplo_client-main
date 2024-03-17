import 'package:flutter/cupertino.dart';

import '../../../../resources/styles/app_text_style.dart';

class OrderDetailsRow extends StatelessWidget {
  final bool isTotal;
  final String name;
  final String value;
  const OrderDetailsRow(
      {Key? key, required this.name, required this.value, this.isTotal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: isTotal
                ? AppTextStyle.textStyleSemiBoldGold16
                : AppTextStyle.textStyleRegularGray,
          ),
          Text(
            value,
            style: isTotal
                ? AppTextStyle.textStyleSemiBoldGold16
                : AppTextStyle.textStyleRegularGray,
          )
        ],
      ),
    );
  }
}
