import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/cart/presentation/widgets/apply_discount.dart';
import 'package:shoplo_client/features/cart/presentation/widgets/cart_address.dart';
import 'package:shoplo_client/widgets/form_field/date_picker.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../my_orders/presentation/widgets/product_cart_card.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/preview_order.dart';
import '../cubit/add_order_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_price.dart';

class PreviewCartGoogleStoreScreen extends HookWidget {
  final Map<String, String> orderData;
  const PreviewCartGoogleStoreScreen({
    super.key,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController(text: orderData['notes']);
    final priceController = useTextEditingController(text: orderData['order_price']);
    final fromController = useTextEditingController(text: orderData['delivery_date']);
    final toController = useTextEditingController(text: orderData['delivery_date_to']);
    final addressController = useTextEditingController(text: orderData['user_address_id']);

    return Scaffold(
      appBar: appAppBar(
        context,
        context.tr.order_summary,
      ), //orderData['storeName']!
      body: NetworkSensitive(
        child: BlocProvider(
          create: (context) => AddOrderCubit()..previewOrder(orderData),
          child: BlocConsumer<AddOrderCubit, AddOrderState>(
            listener: (context, state) {},
            builder: (context, state) {
              return AppConditionalBuilder(
                loadingCondition: state is PreviewOrderLoadingState,
                emptyCondition: state is PreviewOrderSuccessState && state.order == null,
                errorCondition: state is PreviewOrderErrorState,
                errorMessage: state is PreviewOrderErrorState ? state.error : '',
                successCondition: state is PreviewOrderSuccessState,
                successBuilder: (context) {
                  PreviewOrderModal? previewOrder;
                  if (state is PreviewOrderSuccessState) {
                    previewOrder = state.order;
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizedBox.sizedH10,
                          AppTextFormField(
                            readOnly: true,
                            label: context.tr.description,
                            controller: descriptionController,
                            maxLine: 7,
                          ),
                          AppSizedBox.sizedH10,
                          if (orderData['order_type'] == 'outer')
                            AppTextFormField(
                              readOnly: true,
                              label: context.tr.price,
                              controller: priceController,
                            ),
                          if (orderData['order_type'] == 'inner')
                            Text(
                              context.tr.your_order,
                            ),
                          if (orderData['order_type'] == 'inner')
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                CartCubit cubit = CartCubit.get(context);
                                return AppList(
                                  key: const Key('cartList'),
                                  fetchPageData: (query) => {cubit.getCart(query)},
                                  loadingListItems: state is CartLoadingState,
                                  hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                                  endLoadingFirstTime: cubit.endLoadingFirstTime,
                                  itemBuilder: (context, index) => ProductCartCard(
                                    cartData: cubit.cart[index],
                                    readOnly: true,
                                  ),
                                  listItems: cubit.cart,
                                );
                              },
                            ),
                          AppSizedBox.sizedH10,
                          Text(context.tr.delivery_time),
                          AppSizedBox.sizedH5,
                          AppDatePicker(
                            readOnly: true,
                            type: 'dateTime',
                            controller: fromController,
                            label: context.tr.from,
                          ),
                          AppSizedBox.sizedH10,
                          AppDatePicker(
                            readOnly: true,
                            type: 'dateTime',
                            controller: toController,
                            label: context.tr.to,
                          ),
                          AppSizedBox.sizedH10,
                          if (orderData["store_id"]?.isNotEmpty == true && orderData["order_type"] == "inner")
                            ApplyDiscount(
                              storeID: orderData["store_id"].toString(),
                              onApply: (s) {
                                orderData["promo_code"] = s;
                                AddOrderCubit.get(context).previewOrder(orderData);
                              },
                              onDelete: (s) {
                                orderData.remove("promo_code");
                                AddOrderCubit.get(context).previewOrder(orderData);
                              },
                              code: orderData["promo_code"],
                              isSelected: previewOrder?.promoCodeType.isNotEmpty == true,
                            ),
                          AppSizedBox.sizedH10,
                          CartAddressWidget(
                            controller: addressController,
                          ),
                          AppSizedBox.sizedH10,
                          CartPriceWidget(order: previewOrder!),
                          AppSizedBox.sizedH30,
                          AppButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.paymentScreen, arguments: {
                                'orderData': orderData,
                                'previewOrder': previewOrder,
                              });
                            },
                            value: "${previewOrder.total} ${CurrencyHelper.currencyString(context)}",
                            title: context.tr.confirm_order,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
