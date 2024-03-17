import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/styles/app_sized_box.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../widgets/order_details_row.dart';

class EditOrder extends StatelessWidget {
  final int orderId;

  const EditOrder({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(context, context.tr.edit_order),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.your_order,
                      style: AppTextStyle.textStyleRegularGrayLight,
                    ),
                  ],
                ),
                AppSizedBox.sizedH10,
                // const ProductCartCard(),
                // const ProductCartCard(),
                Card(
                  elevation: 3,
                  color: AppColors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(Constants.padding15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Price Details(1 items)",
                              style: AppTextStyle.textStyleRegularGrayLight12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * .01,
                        ),
                        OrderDetailsRow(
                          name: "Subtitle",
                          value: "6.0 ${CurrencyHelper.currencyString(context)}",
                        ),
                        OrderDetailsRow(
                          name: "Tax & Fees",
                          value: "6.0 ${CurrencyHelper.currencyString(context)}",
                        ),
                        OrderDetailsRow(
                          name: "Delivery Fee",
                          value: "6.0 ${CurrencyHelper.currencyString(context)}",
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: AppColors.textAppGray.withOpacity(.2),
                        ),
                        OrderDetailsRow(name: "Total", value: "66.0 ${CurrencyHelper.currencyString(context)}", isTotal: true),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(Constants.padding15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisl pretium ut fusce nunc. Ultrices diam, mauris convallis varius commodo neque faucibus vitae mattis. ",
                            style: AppTextStyle.textStyleRegularGray,
                          ),
                        ],
                      ),
                    )),
                AppButton(onPressed: () {}, title: context.tr.save),
                SizedBox(
                  height: context.height * .025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
