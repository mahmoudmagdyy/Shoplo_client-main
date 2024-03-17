import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/my_orders/presentation/cubit/order_cubit.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/widgets/app_button.dart';
import 'package:shoplo_client/widgets/app_loading.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button_outline.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../../widgets/separator_builder.dart';
import '../../../cart/data/models/cart.dart';
import '../../../cart/data/models/preview_order.dart';
import '../../../cart/presentation/widgets/cart_deliver_to.dart';
import '../../../cart/presentation/widgets/cart_price.dart';
import '../cubit/cubit/order_details_cubit.dart';
import '../widgets/app_button_outline_red.dart';
import '../widgets/complaint_dialog.dart';
import '../widgets/product_cart_card.dart';
import '../widgets/rate_dialog.dart';
import '../widgets/reason_dialog.dart';

class OrderDetails extends HookWidget {
  final int orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    final downloadInvoice = useState(false);

    useEffect(() {
      context.read<OrderDetailsCubit>().getOrderDetails(orderId);
      return null;
    }, [orderId, context.watch<OrderCubit>().refreshOrderDetails]);

    return Scaffold(
      appBar: appAppBar(
        context,
        context.tr.order_details,
        actions: [
          if (downloadInvoice.value)
            SvgPicture.asset(AppImages.download, color: AppColors.primaryL),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Image.asset(AppImages.download),
          // ),
        ],
      ),
      body: NetworkSensitive(
        child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetOrderDetailsLoadingState) {
              return const AppLoading();
            } else if (state is GetOrderDetailsSuccessState) {
              descriptionController.text = state.orderModel.notes;
              priceController.text = state.orderModel.total;
              final orderModel = state.orderModel;
              descriptionController.text = orderModel.notes;
              priceController.text = orderModel.total;

              if (orderModel.status.key == 'delivery_done') {
                debugPrint('DELIVERY_DONE: ', wrapWidth: 1024);
                downloadInvoice.value = true;
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      if (orderModel.orderType == 'inner')
                        ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          // controller: _scrollController,
                          itemCount: orderModel.items.length,
                          separatorBuilder: separatorBuilder,
                          itemBuilder: (context, index) {
                            return ProductCartCard(
                              cartData:
                                  // order.items[index],
                                  CartModal(
                                id: orderModel.items[index].id,
                                product: orderModel.items[index].product,
                                quantity: orderModel.items[index].quantity,
                                createdAt: '',
                              ),
                              readOnly: true,
                            );
                          },
                        ),
                      if (orderModel.notes.isNotEmpty)
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
                              //   child:  Center(
                              //     child: Text(
                              //       '${orderModel.subtotal}$',
                              //       style: AppTextStyle.textStyleSemiBoldGold16,
                              //     ),
                              //   ),
                              // ),
                              controller: priceController,
                            ),
                          ],
                        ),
                      CartDeliverToWidget(order: orderModel),
                      AppSizedBox.sizedH10,
                      CartPriceWidget(
                        order: PreviewOrderModal(
                          subtotal: orderModel.subtotal,
                          offerDiscount: orderModel.offerDiscount,
                          deliveryCharge: orderModel.deliveryCharge,
                          promoCodeDiscount: orderModel.promoCodeDiscount,
                          //order.promoCodeDiscount,
                          promoCodeType: "",
                          //order.promoCodeType,
                          total: orderModel.total,
                          addedTax: orderModel.addedTax,
                          wallet: '',
                          //order.wallet,
                          walletPayout: orderModel.walletPayout,
                          remain: '', // order.remain,
                        ),
                      ),
                      AppSizedBox.sizedH10,
                      Card(
                        elevation: 0,
                        color: AppColors.textAppGrayLight.withOpacity(.1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(Constants.padding15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    context.tr.order_status,
                                    style: AppTextStyle.textStyleRegularGray,
                                  ),
                                  Text(
                                    orderModel.status.name,
                                    style: orderModel.status.key == "new"
                                        ? AppTextStyle.textStyleRegularPrimary
                                        : (orderModel.status.key ==
                                                    'delivering' ||
                                                orderModel.status.key ==
                                                    'delivered' ||
                                                orderModel.status.key ==
                                                    'delivery_done')
                                            ? AppTextStyle.textStyleRegularGold
                                            : AppTextStyle.textStyleRegularGray,
                                  )
                                ],
                              ),
                              if (orderModel.status.key == 'rejected' ||
                                  orderModel.status.key == 'canceled')
                                SizedBox(
                                  width: context.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        height: 10,
                                        thickness: 1,
                                        color: AppColors.textAppGray
                                            .withOpacity(.2),
                                      ),
                                      Text(
                                        orderModel.rejectReason,
                                        style:
                                            AppTextStyle.textStyleRegularGray,
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * .025,
                      ),
                      if (orderModel.status.key == "new")
                        AppButton(
                            loading: false,
                            onPressed: () async {
                              return showDialog(
                                context: context,
                                // barrierColor: AppColors.primaryL.withOpacity(.5),
                                builder: (BuildContext context) {
                                  return ReasonDialog(
                                    orderId: orderModel.id,
                                  );
                                },
                              );
                            },
                            title: context.tr.cancel),
                      if (orderModel.status.key == 'delivering')
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: AppButtonOutline(
                                  title: context.tr.call,
                                  onPressed: () {
                                    launchUrlString(
                                        "tel://${orderModel.deliveryUser!.phone}");
                                  },
                                  height: context.height * .055,
                                  iconChild: SvgPicture.asset(
                                    AppImages.phone,
                                  ),
                                ),
                              ),
                              AppSizedBox.sizedW5,
                              Expanded(
                                child: AppButtonOutline(
                                  title: context.tr.chat,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.chatScreen,
                                      arguments: {
                                        "orderId": orderModel.id,
                                        "deliveryName":
                                            orderModel.deliveryUser!.name,
                                      },
                                    );
                                  },
                                  height: context.height * .055,
                                  iconChild: SvgPicture.asset(
                                    AppImages.chat,
                                  ),
                                ),
                              ),
                              AppSizedBox.sizedW5,
                              Expanded(
                                child: AppButtonOutlineRed(
                                  title: context.tr.make_complaint,
                                  onPressed: () async {
                                    return showDialog(
                                      context: context,
                                      // barrierColor: AppColors.primaryL.withOpacity(.5),
                                      builder: (BuildContext context) {
                                        return const ComplaintDialog();
                                      },
                                    );
                                  },
                                  height: context.height * .055,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (orderModel.status.key == "delivered")
                        BlocConsumer<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is ChangeOrderStatusSuccessState) {
                              AppToast.showToastSuccess(
                                  context.tr.update_successfully);
                            }
                            if (state is ChangeOrderStatusErrorState) {
                              AppSnackBar.showError(state.error);
                            }
                          },
                          builder: (context, state) {
                            return AppButton(
                              loading: state is ChangeOrderStatusLoadingState,
                              onPressed: () {
                                context
                                    .read<OrderCubit>()
                                    .changeOrderStatus(orderModel.id, {
                                  "status": "delivery_done",
                                });
                              },
                              title: context.tr.complete,
                            );
                          },
                        ),
                      if (orderModel.status.key == 'delivery_done' &&
                          !orderModel.isRate)
                        AppButtonOutline(
                          title: context.tr.rate,
                          onPressed: () async {
                            return showDialog(
                              context: context,
                              // barrierColor: AppColors.primaryL.withOpacity(.5),
                              builder: (BuildContext context) {
                                return RateDialog(
                                  orderId: orderId,
                                );
                              },
                            );
                          },
                          height: context.height * .055,
                        )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
