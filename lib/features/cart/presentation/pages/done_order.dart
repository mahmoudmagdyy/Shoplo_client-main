import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/cart/data/models/preview_order.dart';
import 'package:shoplo_client/widgets/app_button_outline.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/separator_builder.dart';
import '../../../my_orders/data/models/order.dart';
import '../../../my_orders/presentation/widgets/product_cart_card.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/cart.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_deliver_to.dart';
import '../widgets/cart_price.dart';

class DoneOrderScreen extends HookWidget {
  final OrderModel order;
  const DoneOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController(text: order.notes);
    final priceController = useTextEditingController(text: order.subtotal);
    return WillPopScope(
      onWillPop: () async {
        debugPrint("onWillPop");

        // CartCubit cartCubit = CartCubit.get(context);
        // cartCubit.setCartCount(0);
        Navigator.of(context).popUntil(
          (route) => route.settings.name == AppRoutes.appHome,
        );
        return false;
      },
      child: Scaffold(
        // appBar: appAppBar(context, context.tr.place_order),
        body: NetworkSensitive(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.asset(
                          AppImages.success,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSizedBox.sizedH10,
                          const Icon(
                            Icons.check_circle,
                            size: 50,
                            color: AppColors.primaryL,
                          ),
                          AppSizedBox.sizedH10,
                          Text(
                            context.tr.thank_you,
                            style: AppTextStyle.textStyleMediumGold,
                          ),
                          Text(
                            order.orderType == "scheduled" ? context.tr.wating_for_admin_review : context.tr.payment_successfully,
                            style: AppTextStyle.textStyleMediumGray,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSizedBox.sizedH10,
                  AppSizedBox.sizedH5,
                  if (order.orderType == 'inner')
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // controller: _scrollController,
                      itemCount: order.items.length,
                      separatorBuilder: separatorBuilder,
                      itemBuilder: (context, index) {
                        return ProductCartCard(
                          cartData:
                              // order.items[index],
                              CartModal(
                            id: order.items[index].id,
                            product: order.items[index].product,
                            quantity: order.items[index].quantity,
                            createdAt: '',
                          ),
                          readOnly: true,
                        );
                      },
                    ),
                  if (order.notes.isNotEmpty)
                    Column(
                      children: [
                        AppTextFormField(
                          readOnly: true,
                          label: context.tr.description,
                          controller: descriptionController,
                          maxLine: 7,
                        ),
                        AppSizedBox.sizedH10,
                        AppTextFormField(
                          readOnly: true,
                          label: context.tr.price,
                          // suffixIcon: SizedBox(
                          //   width: context.width * .1,
                          //   child: const Center(
                          //     child: Text(
                          //       '12\$',
                          //       style: AppTextStyle.textStyleSemiBoldGold16,
                          //     ),
                          //   ),
                          // ),
                          controller: priceController,
                        ),
                      ],
                    ),
                  AppSizedBox.sizedH10,
                  if (order.userAddress != null) CartDeliverToWidget(order: order),
                  AppSizedBox.sizedH10,
                  CartPriceWidget(
                    showTaxAndDelivery: order.orderType == 'scheduled' ? false : true,
                    order: PreviewOrderModal(
                      subtotal: order.subtotal,
                      offerDiscount: order.offerDiscount,
                      deliveryCharge: order.deliveryCharge,
                      promoCodeDiscount: '', //order.promoCodeDiscount,
                      promoCodeType: '', //order.promoCodeType,
                      total: order.total,
                      addedTax: order.addedTax,
                      wallet: '', //order.wallet,
                      walletPayout: order.walletPayout,
                      remain: '', // order.remain,
                    ),
                  ),
                  AppSizedBox.sizedH20,
                  AppButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.orderDetails, arguments: {"orderId": order.id});
                    },
                    title: context.tr.track_order,
                  ),
                  AppSizedBox.sizedH10,
                  AppButtonOutline(
                    title: context.tr.home,
                    onPressed: () {
                      CartCubit cartCubit = CartCubit.get(context);
                      cartCubit.getCart({});
                      Navigator.popUntil(
                        context,
                        (route) => (route.settings.name == AppRoutes.appHome || route.settings.name == AppRoutes.selectMainService),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
