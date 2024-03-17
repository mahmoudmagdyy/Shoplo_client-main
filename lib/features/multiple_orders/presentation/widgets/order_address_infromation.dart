import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';

class OrderAddressInformation extends StatelessWidget {
  const OrderAddressInformation({
    super.key,
    this.address,
  });

  final String? address;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.tr.address} : ",
              style: AppTextStyle.textStyleBoldBlack,
            ),
            Row(
              children: [
                SvgPicture.asset(AppImages.car),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    address ?? "",
                    style: AppTextStyle.textStyleMediumGray,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
