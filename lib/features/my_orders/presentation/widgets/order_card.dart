import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/my_orders/presentation/widgets/rate_dialog.dart';
import 'package:shoplo_client/features/my_orders/presentation/widgets/reason_dialog.dart';
import 'package:shoplo_client/widgets/index.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/config/map_config.dart';
import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button_outline.dart';
import '../../../../widgets/app_toast.dart';
import '../../data/models/order.dart';
import '../cubit/order_cubit.dart';
import 'app_button_outline_red.dart';
import 'complaint_dialog.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;

  const OrderCard({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (orderModel.storeName.isEmpty) {
          Navigator.of(context).pushNamed(AppRoutes.multipleOrdersDetails, arguments: {"orderId": orderModel.id});
          return;
        }
        Navigator.of(context).pushNamed(AppRoutes.orderDetails, arguments: {"orderId": orderModel.id});
      },
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${context.tr.order_id} ${orderModel.id}",
                    style: AppTextStyle.textStyleRegularGrayLight12,
                  ),
                  if (orderModel.status.key == 'new')
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryL.withOpacity(.7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Text(
                          context.tr.new_,
                          style: AppTextStyle.textStyleMediumPrimaryNative12,
                        ),
                      ),
                    ),
                  if (orderModel.status.key == 'delivering' || orderModel.status.key == 'delivered')
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textAppGold.withOpacity(.7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Text(
                          orderModel.status.name,
                          style: AppTextStyle.textStyleMediumGold12,
                        ),
                      ),
                    ),
                  if (orderModel.status.key == 'delivery_done')
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondaryL.withOpacity(.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Text(
                          orderModel.status.name,
                          style: AppTextStyle.textStyleMediumSecondary12,
                        ),
                      ),
                    ),
                  if (orderModel.status.key == 'rejected' || orderModel.status.key == 'canceled')
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textAppGray.withOpacity(.7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Text(
                          orderModel.status.name,
                          style: AppTextStyle.textStyleMediumGray12,
                        ),
                      ),
                    ),
                ],
              ),
              Divider(
                color: AppColors.grey.withOpacity(.2),
                height: 10,
                thickness: 1,
              ),
              SizedBox(
                height: context.height * .01,
              ),
              OrderSemiCard(
                orderModel: orderModel,
              ),
              SizedBox(
                height: context.height * .02,
              ),
              if (orderModel.status.key == 'new')
                AppButtonOutline(
                  loading: false,
                  title: context.tr.cancel,
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
                  height: context.height * .055,
                ),
              if (orderModel.status.key == 'delivering')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButtonOutline(
                        title: context.tr.call,
                        onPressed: () {
                          launchUrlString("tel://${orderModel.deliveryUser!.phone}");
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
                              "deliveryName": orderModel.deliveryUser!.name,
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
              if (orderModel.status.key == "delivered")
                BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {
                    if (state is ChangeOrderStatusSuccessState) {
                      AppToast.showToastSuccess(context.tr.update_successfully);
                      // serviceLocator<OrderCubit>().getOrders({
                      //   "status": "current",
                      // });
                      // Navigator.of(context).pop();
                    }
                    if (state is ChangeOrderStatusErrorState) {
                      AppToast.showToastError(state.error);
                    }
                  },
                  builder: (context, state) {
                    return AppButtonOutline(
                      loading: state is ChangeOrderStatusLoadingState,
                      onPressed: () async {
                        context.read<OrderCubit>().changeOrderStatus(orderModel.id, {
                          "status": "delivery_done",
                        });
                      },
                      title: orderModel.orderType == "scheduled" ? context.tr.deliver_complete : context.tr.complete,
                    );
                  },
                ),
              if (orderModel.status.key == 'delivery_done' && !orderModel.isRate)
                AppButtonOutline(
                  title: context.tr.rate,
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      // barrierColor: AppColors.primaryL.withOpacity(.5),
                      builder: (BuildContext context) {
                        return RateDialog(
                          orderId: orderModel.id,
                        );
                      },
                    );
                  },
                  height: context.height * .055,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSemiCard extends StatelessWidget {
  final OrderModel orderModel;

  const OrderSemiCard({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (orderModel.orderType == "scheduled")
          Image.asset(
            AppImages.deliveryIcon,
            width: context.width * .2,
            height: context.width * .2,
            fit: BoxFit.cover,
          )
        else
          AppImage(
            width: context.width * .2,
            height: context.width * .2,
            borderRadius: 10,
            fit: BoxFit.cover,
            imageURL: orderModel.orderType != "outer"
                ? orderModel.storeImage
                : orderModel.storeImage.contains('/place_api/icons')
                    ? orderModel.storeImage
                    : 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=120&photo_reference=${orderModel.storeImage}&key=${MapConfiguration.apiKeyMaps}',
          ),
        SizedBox(
          width: context.width * .025,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderModel.storeName.isEmpty ? context.tr.delivery_with_multiple_orders : orderModel.storeName,
                style: AppTextStyle.textStyleEditTextLabelRegularGray,
              ),
              Wrap(
                children: [
                  if (orderModel.orderType != "outer")
                    Row(
                      children: [
                        Text(
                          context.tr.product_count,
                          style: AppTextStyle.textStyleRegularGold.copyWith(fontSize: 12),
                        ),
                        Text(
                          " (${orderModel.itemCount} ${context.tr.item}) ",
                          style: AppTextStyle.textStyleRegularGold.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  Text(
                    "${orderModel.total} ${CurrencyHelper.currencyString(context)}",
                    style: AppTextStyle.textStyleRegularGold.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.textAppGray),
                  Text(
                    orderModel.userAddress?.title ?? "",
                    style: AppTextStyle.textStyleEditTextLabelRegularGray,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
