import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

import '../../../../resources/images/images.dart';

class AddNewOrderWidget extends StatelessWidget {
  const AddNewOrderWidget({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(context.tr.describe_your_order,
              style: AppTextStyle.textStyleBoldBlack.copyWith(fontSize: 12)),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(context.tr.add,
                    style:
                        AppTextStyle.textStyleBoldBlack.copyWith(fontSize: 12)),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  AppImages.add,
                  height: 20,
                  width: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
