import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../my_orders/presentation/widgets/order_details_row.dart';
import '../../data/models/preview_order.dart';

class CartPriceWidget extends StatelessWidget {
  final PreviewOrderModal order;
  final int cartCount;

  const CartPriceWidget({
    super.key,
    this.cartCount = 0,
    required this.order,
    this.showTaxAndDelivery = true,
    this.showSubTotal = true,
  });
  final bool showTaxAndDelivery;
  final bool showSubTotal;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(Constants.padding15),
        child: Column(
          children: [
            if (cartCount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${context.tr.price_details} ( $cartCount ${context.tr.product} ) ',
                    style: AppTextStyle.textStyleRegularGrayLight12,
                  ),
                ],
              ),
            SizedBox(
              height: context.height * .01,
            ),
            if (showSubTotal)
              OrderDetailsRow(
                name: context.tr.sub_price,
                value: '${order.subtotal} ${CurrencyHelper.currencyString(context)}',
              ),
            if (order.promoCodeDiscount.toDouble != 0)
              OrderDetailsRow(
                name: context.tr.coupon_discount,
                value: '${order.promoCodeDiscount} ${CurrencyHelper.currencyString(context)}',
              ),
            if (order.addedTax.isNotEmpty)
              if (showTaxAndDelivery)
                OrderDetailsRow(
                  name: context.tr.tax_fees,
                  value: '${order.addedTax} ${CurrencyHelper.currencyString(context)}',
                ),
            if (order.deliveryCharge.isNotEmpty)
              if (showTaxAndDelivery)
                OrderDetailsRow(
                  name: context.tr.delivery_fee,
                  value: '${order.deliveryCharge} ${CurrencyHelper.currencyString(context)}',
                ),
            Divider(
              height: 10,
              thickness: 1,
              color: AppColors.textAppGray.withOpacity(.2),
            ),
            OrderDetailsRow(
              name: context.tr.total,
              value: '${order.total} ${CurrencyHelper.currencyString(context)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}
