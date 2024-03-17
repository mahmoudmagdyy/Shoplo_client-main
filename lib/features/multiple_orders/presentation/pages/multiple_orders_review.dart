import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_datetime.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../domain/request/create_mutiple_order_request.dart';
import '../cubit/multiple_orders_review_cubit.dart';
import '../widgets/country_information.dart';
import '../widgets/from_to__information_widget.dart';
import '../widgets/order_address_infromation.dart';
import '../widgets/order_store_requierments.dart';

class MultipleOrdersReviewScreen extends HookWidget {
  const MultipleOrdersReviewScreen({
    super.key,
    required this.createRequest,
  });
  final CreateMultipleOrderRequest createRequest;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultipleOrdersReviewCubit(),
      child: Scaffold(
          appBar: appAppBar(context, context.tr.order_summary),
          body: NetworkSensitive(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CountryInformation(
                      state: createRequest.state?.name,
                      fromCity: createRequest.fromCity?.name,
                      toCity: createRequest.toAddress?.city.name,
                      country: createRequest.country?.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FromAndToInformation(
                      fromDate: createRequest.from?.formattedDate,
                      toDate: createRequest.to?.formattedDate,
                      fromTime: createRequest.from?.formattedTime,
                      toTime: createRequest.to?.formattedTime,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OrderAddressInformation(address: createRequest.toAddress?.address),
                    const SizedBox(
                      height: 15,
                    ),
                    ...createRequest.stores.map(
                      (e) => OrderStoreRequirements(
                        details: e.notes,
                        location: e.storeAddress,
                        expectedPrice: e.subtotal,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OrderTotalInformation(
                      deliveryFees: createRequest.total?.deliveryCharge ?? "",
                      taxFees: createRequest.total?.addedTax ?? "",
                      totalExpected: createRequest.total?.subtotal ?? "",
                      total: createRequest.total?.total ?? "",
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<MultipleOrdersReviewCubit, MultipleOrdersReviewState>(listener: (context, state) {
                      if (state is MultipleOrdersReviewSuccess) {
                        Navigator.of(context).pushNamed(
                          AppRoutes.doneOrderScreen,
                          arguments: state.orderModel,
                        );
                      }

                      if (state is MultipleOrdersReviewError) {
                        AppSnackBar.showError(state.message);
                      }
                    }, builder: (context, state) {
                      return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryL,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: state is MultipleOrdersReviewLoading
                                ? null
                                : () {
                                    context.read<MultipleOrdersReviewCubit>().createOrder(createRequest);
                                  },
                            child: state is MultipleOrdersReviewLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  )
                                : Text(context.tr.confirm),
                          ));
                    }),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(context.tr.cancel),
                        )),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class OrderTotalInformation extends StatelessWidget {
  const OrderTotalInformation({
    super.key,
    required this.totalExpected,
    required this.deliveryFees,
    required this.taxFees,
    required this.total,
  });

  final String totalExpected;
  final String deliveryFees;
  final String taxFees;
  final String total;

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
            Row(
              children: [
                Text(
                  context.tr.total_expected_price,
                  style: AppTextStyle.textStyleMediumGray,
                ),
                Expanded(
                  child: Text(
                    "$totalExpected ${CurrencyHelper.currencyString(context)}",
                    textAlign: TextAlign.end,
                    style: AppTextStyle.textStyleMediumGray,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  context.tr.delivery_fee,
                  style: AppTextStyle.textStyleMediumGray,
                ),
                Expanded(
                  child: Text(
                    "$deliveryFees ${CurrencyHelper.currencyString(context)}",
                    textAlign: TextAlign.end,
                    style: AppTextStyle.textStyleMediumGray,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  context.tr.tax_fees,
                  style: AppTextStyle.textStyleMediumGray,
                ),
                Expanded(
                  child: Text(
                    "$taxFees ${CurrencyHelper.currencyString(context)}",
                    textAlign: TextAlign.end,
                    style: AppTextStyle.textStyleMediumGray,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  context.tr.total,
                  style: AppTextStyle.textStyleSemiBoldGold,
                ),
                Expanded(
                  child: Text(
                    "$total ${CurrencyHelper.currencyString(context)}",
                    textAlign: TextAlign.end,
                    style: AppTextStyle.textStyleSemiBoldGold,
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
