import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_list.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/form_field/date_picker.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../my_orders/presentation/widgets/product_cart_card.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../data/models/preview_order.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_address.dart';
import '../widgets/cart_price.dart';

class CompleteOrderScreen extends HookWidget {
  final Map<String, String> orderData;
  const CompleteOrderScreen({
    super.key,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = UserCubit.get(context);

    final fromController = useTextEditingController();
    final toController = useTextEditingController();
    final addressController = useTextEditingController(
        text: userCubit.userData!.user.addresses.isNotEmpty
            ? userCubit.userData!.user.addresses[0].id.toString()
            : '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final dateTime = useState(DateTime.now());

    useEffect(() {
      if (userCubit.userData != null &&
          userCubit.userData!.user.addresses.isNotEmpty) {
        CartCubit.get(context)
            .setCartAddress(userCubit.userData!.user.addresses[0]);
      }
      return null;
    }, [userCubit.userData]);

    return Scaffold(
      appBar: appAppBar(context, context.tr.place_order),
      body: NetworkSensitive(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CartAddressWidget(
                    controller: addressController,
                  ),
                  AppSizedBox.sizedH5,
                  Text(
                    context.tr.your_order,
                  ),
                  AppSizedBox.sizedH5,
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      CartCubit cubit = CartCubit.get(context);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppList(
                            key: const Key('cartList'),
                            fetchPageData: (query) => {cubit.getCart(query)},
                            loadingListItems: state is CartLoadingState,
                            hasReachedEndOfResults:
                                cubit.hasReachedEndOfResults,
                            endLoadingFirstTime: cubit.endLoadingFirstTime,
                            itemBuilder: (context, index) => ProductCartCard(
                              cartData: cubit.cart[index],
                              // readOnly: true,
                            ),
                            listItems: cubit.cart,
                          ),
                          AppSizedBox.sizedH10,
                          Text(context.tr.delivery_time),
                          AppSizedBox.sizedH5,
                          AppDatePicker(
                            type: 'dateTime',
                            controller: fromController,
                            label: context.tr.from,
                            onInit: (val) {
                              dateTime.value = val;
                              debugPrint(
                                  "get time picker data ${dateTime.value}");
                            },
                          ),
                          AppSizedBox.sizedH10,
                          AppDatePicker(
                            type: 'dateTime',
                            controller: toController,
                            firstDate: dateTime.value,
                            label: context.tr.to,
                            onInit: (val) {
                              //  dateTime.value = val;
                            },
                          ),
                          AppSizedBox.sizedH10,
                          CartPriceWidget(
                            order: PreviewOrderModal(
                              subtotal: cubit.subTotal,
                              offerDiscount: '',
                              deliveryCharge: '',
                              promoCodeDiscount: '',
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
                              if (formKey.currentState!.validate()) {
                                Map<String, String> data = {
                                  "user_address_id": CartCubit.get(context)
                                      .cartAddress!
                                      .id
                                      .toString(), // addressController.text,
                                  "order_type": "inner",
                                  "store_id": CartCubit.get(context)
                                          .cartStore
                                          ?.id
                                          .toString() ??
                                      "",
                                  "delivery_date": fromController.text,
                                  "delivery_date_to": toController.text,
                                  "use_wallet": '1',
                                  ...orderData,
                                };
                                debugPrint('DATA: $data', wrapWidth: 1024);
                                if (cubit.cart.isNotEmpty) {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.previewCartGoogleStoreScreen,
                                    arguments: data,
                                  );
                                } else {
                                  AppToast.showToastError(
                                      context.tr.no_product_in_cart);
                                }
                              }
                            },
                            // value: "${cubit.subTotal}\$",
                            title: context.tr.order_summary,
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
      ),
    );
  }
}
