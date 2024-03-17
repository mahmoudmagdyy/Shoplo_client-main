import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../widgets/two_parts_text.dart';

class CountryInformation extends StatelessWidget {
  const CountryInformation({
    super.key,
    this.state,
    this.fromCity,
    this.toCity,
    this.country,
    this.orderId,
  });
  final String? state;
  final String? fromCity;
  final String? toCity;
  final String? country;
  final String? orderId;

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
          children: [
            TwoPartText(
              title: context.tr.order_id,
              value: orderId ?? "",
            ),
            if (orderId != null) const Divider(),
            if (country != null)
              TwoPartText(
                title: context.tr.country,
                value: country ?? "",
              ),
            if (state != null)
              TwoPartText(title: context.tr.state, value: state ?? ""),
            if (fromCity != null)
              TwoPartText(title: context.tr.from_city, value: fromCity ?? ""),
            if (toCity != null)
              TwoPartText(title: context.tr.to_city, value: toCity ?? ""),
          ],
        ),
      ),
    );
  }
}
