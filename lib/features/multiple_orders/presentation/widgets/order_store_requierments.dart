import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/widgets/app_image.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/two_parts_text.dart';

class OrderStoreRequirements extends StatelessWidget {
  const OrderStoreRequirements({
    Key? key,
    required this.location,
    required this.details,
    required this.expectedPrice,
    this.status,
    this.rejectReason,
    this.actualPrice,
    this.receiptImage,
  }) : super(key: key);
  final String location;
  final String details;
  final String expectedPrice;
  final String? status;
  final String? rejectReason;
  final String? actualPrice;
  final String? receiptImage;

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${context.tr.order_store_and_requirements} :",
              style: AppTextStyle.textStyleBoldBlack,
            ),
            TwoPartText(
              title: context.tr.store_location,
              value: location,
            ),
            TwoPartText(
              title: context.tr.order_details,
              value: details,
            ),
            TwoPartText(title: context.tr.expected_price, value: "$expectedPrice ${CurrencyHelper.currencyString(context)}"),
            if (receiptImage != null)
              AppImage(
                imageURL: receiptImage!,
                imageViewer: true,
                width: 100,
                height: 100,
              ),
            if (status != null) TwoPartText(title: context.tr.order_status, value: status ?? ""),
            if (rejectReason != null) TwoPartText(title: context.tr.reject_reason, value: rejectReason ?? ""),
            if (actualPrice != null) TwoPartText(title: context.tr.actual_price, value: "$actualPrice ${CurrencyHelper.currencyString(context)}"),
          ],
        ),
      ),
    );
  }
}
