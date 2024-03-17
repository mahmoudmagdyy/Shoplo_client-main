import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/cart/data/models/preview_order.dart';
import 'package:shoplo_client/features/my_orders/presentation/widgets/product_cart_card.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_price.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    return Scaffold(
      appBar: appAppBar(context, context.tr.cart),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.your_order,
                  style: AppTextStyle.textStyleRegularBlack,
                ),
                AppSizedBox.sizedH5,
                // ListView.separated(
                //   physics: const BouncingScrollPhysics(),
                //   shrinkWrap: true,
                //   // controller: _scrollController,
                //   itemCount: 2,
                //   separatorBuilder: separatorBuilder,
                //   itemBuilder: (context, index) {
                //     return const ProductCartCard();
                //   },
                // ),

                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    CartCubit cubit = CartCubit.get(context);
                    return Column(
                      children: [
                        AppList(
                          key: const Key('cartList'),
                          fetchPageData: (query) => {cubit.getCart(query)},
                          loadingListItems: state is CartLoadingState,
                          hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                          endLoadingFirstTime: cubit.endLoadingFirstTime,
                          itemBuilder: (context, index) => ProductCartCard(
                            key: ValueKey(cubit.cart[index].id),
                            cartData: cubit.cart[index],
                          ),
                          listItems: cubit.cart,
                        ),
                        AppSizedBox.sizedH10,
                        AppTextFormField(
                          // readOnly: true,
                          label: context.tr.description,
                          controller: descriptionController,
                          maxLine: 7,
                        ),
                        CartPriceWidget(
                          order: PreviewOrderModal(
                            subtotal: cubit.subTotal,
                            offerDiscount: '',
                            deliveryCharge: '',
                            promoCodeDiscount: '0',
                            promoCodeType: '',
                            total: cubit.subTotal,
                            addedTax: '',
                            wallet: '',
                            walletPayout: '',
                            remain: '',
                          ),
                          cartCount: cubit.cart.length,
                        ),
                        AppSizedBox.sizedH30,
                        AppButton(
                          onPressed: () {
                            if (cubit.cart.isNotEmpty) {
                              Map<String, String> data = {
                                "storeName": cubit.cartStore!.name,
                                "use_wallet": '1',
                              };

                              if (descriptionController.text.isNotEmpty) {
                                data.addAll({
                                  "notes": descriptionController.text,
                                });
                              }
                              Navigator.of(context).pushNamed(
                                AppRoutes.completeOrderScreen,
                                arguments: data,
                              );
                            }
                          },
                          title: context.tr.complete_order,
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
