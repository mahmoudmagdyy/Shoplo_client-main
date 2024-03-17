import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/my_orders/data/models/order.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../widgets/app_error.dart';
import '../../../../widgets/app_image_viewer.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/shoplo/app_app_bar.dart';
import '../../../../widgets/two_parts_text.dart';
import '../../../cart/data/models/preview_order.dart';
import '../../../cart/presentation/widgets/cart_price.dart';
import '../cubit/ship_by_global_view_cubit.dart';
import '../widgets/cancel_shipping_resone_dialog.dart';

class ShipByGlobalView extends HookWidget {
  const ShipByGlobalView({
    super.key,
    required this.orderId,
  });
  final int orderId;
  @override
  Widget build(BuildContext context) {
    //form

    return BlocProvider(
      create: (context) => ShipByGlobalViewCubit()..shipByGlobalView(orderId),
      child: BlocBuilder<ShipByGlobalViewCubit, ShipByGlobalViewState>(builder: (context, state) {
        return Scaffold(
          appBar: appAppBar(context, context.tr.ship_by_global),
          body: NetworkSensitive(child: Builder(builder: (context) {
            if (state is ShipByGlobalViewLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShipByGlobalViewErrorState) {
              return AppError(
                error: state.errors,
              );
            } else if (state is ShipByGlobalViewSuccessState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      if (state.model.sender != null) ShipByGlobalAddressView(title: context.tr.my_address, address: state.model.sender!),
                      const SizedBox(height: 20),
                      if (state.model.shippings != null && state.model.shippings!.isNotEmpty)
                        ShipByGlobalShipmentDetails(
                          shipping: state.model.shippings!.first,
                        ),
                      const SizedBox(height: 20),
                      if (state.model.sender != null) ShipByGlobalAddressView(title: context.tr.receiver_address, address: state.model.receiver!),
                      const SizedBox(height: 20),
                      if (state.model.adminNotes.isNotEmpty)
                        ShipByGlobalAdminNote(
                          note: state.model.adminNotes,
                        ),
                      const SizedBox(height: 10),
                      CartPriceWidget(
                        showSubTotal: false,
                        showTaxAndDelivery: true,
                        order: PreviewOrderModal(
                          subtotal: state.model.subtotal,
                          offerDiscount: state.model.offerDiscount,
                          deliveryCharge: state.model.deliveryCharge,
                          promoCodeDiscount: '', //state.model.promoCodeDiscount,
                          promoCodeType: '', //state.model.promoCodeType,
                          total: state.model.total,
                          addedTax: state.model.addedTax,
                          wallet: '', //state.model.wallet,
                          walletPayout: state.model.walletPayout,
                          remain: '', // order.remain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (state.model.status.key != "canceled" && state.model.status.key != "delivered")
                        if (state.model.shippingProcessStatus?.key == "waiting_client_approval")
                          BlocProvider(
                            create: (context) => ShipByGlobalViewCubit(),
                            child: BlocConsumer<ShipByGlobalViewCubit, ShipByGlobalViewState>(listener: (context, state) {
                              if (state is ShipByGlobalViewChangeStatusSuccessState) {
                                AppToast.showToastSuccess(context.tr.update_successfully);
                                Navigator.of(context).pop();
                              }
                              if (state is ShipByGlobalViewChangeStatusErrorState) {
                                AppToast.showToastError(state.errors);
                              }
                            }, builder: (context, state) {
                              return state is ShipByGlobalViewChangeStatusLoadingState
                                  ? const Center(child: CircularProgressIndicator())
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryL,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            context.read<ShipByGlobalViewCubit>().changeShippingStatus(orderId, {
                                              "status": "approve",
                                            });
                                          },
                                          child: Text(context.tr.confirm)),
                                    );
                            }),
                          ),
                      if (state.model.status.key != "canceled" && state.model.status.key != "delivered")
                        if (state.model.shippings!.first.status == 1 && state.model.paymentMethod == null)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryL,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.shippingPaymentScreen,
                                      arguments: {"orderId": orderId.toString(), "total": state.model.total.toString()}).then((value) {
                                    context.read<ShipByGlobalViewCubit>().shipByGlobalView(orderId);
                                  });
                                },
                                child: Text(context.tr.payment)),
                          ),
                      const SizedBox(height: 20),
                      if (state.model.status.key != "canceled" && state.model.status.key != "delivered")
                        if (state.model.shippingProcessStatus?.key != "waiting_admin_approval")
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: AppColors.primaryL,
                                  side: const BorderSide(color: AppColors.primaryL),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ReasonShippingCancelDialog(orderId: orderId);
                                    },
                                  );
                                },
                                child: Text(context.tr.cancel)),
                          ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          })),
        );
      }),
    );
  }
}

class ShipByGlobalAdminNote extends StatelessWidget {
  const ShipByGlobalAdminNote({
    super.key,
    required this.note,
  });
  final String note;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.admin_note,
                  style: AppTextStyle.textStyleBoldBlack.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  note,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShipByGlobalAddressView extends StatelessWidget {
  const ShipByGlobalAddressView({
    super.key,
    required this.title,
    required this.address,
  });
  final ShippingAddress address;
  final String title;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.textStyleBoldBlack.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TwoPartText(
                    title: context.tr.country,
                    value: address.city.state.country.name,
                  ),
                ),
                Expanded(
                  child: TwoPartText(
                    title: context.tr.city,
                    value: address.city.name,
                  ),
                ),
              ],
            ),
            TwoPartText(
              title: context.tr.address,
              value: address.address,
            ),
            InkWell(
              onTap: () {
                launchUrlString("tel://${address.phone}");
              },
              child: TwoPartText(
                title: context.tr.phone_number,
                value: address.phone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShipByGlobalShipmentDetails extends StatelessWidget {
  const ShipByGlobalShipmentDetails({
    super.key,
    required this.shipping,
  });
  final Shipping shipping;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.shipping_details,
              style: AppTextStyle.textStyleBoldBlack.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TwoPartText(
              title: context.tr.category,
              value: shipping.category.name ?? "",
            ),
            TwoPartText(
              title: context.tr.height,
              value: shipping.height.toString(),
            ),
            TwoPartText(
              title: context.tr.width,
              value: shipping.width.toString(),
            ),
            TwoPartText(
              title: context.tr.weight,
              value: shipping.weight.toString(),
            ),
            TwoPartText(
              title: context.tr.length,
              value: shipping.length.toString(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                shipping.isPackaging == 1 ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
                const SizedBox(width: 10),
                Flexible(child: Text(context.tr.package_by_global)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                shipping.isBreakable == 1 ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
                const SizedBox(width: 10),
                Flexible(child: Text(context.tr.breakable)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                shipping.isRefrigeration == 1 ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
                const SizedBox(width: 10),
                Flexible(child: Text(context.tr.refrigeration_required)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "${context.tr.shipment_description} : ",
              style: AppTextStyle.textStyleBoldBlack,
            ),
            Text(
              shipping.description,
              style: AppTextStyle.textStyleBoldBlack,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                ...shipping.images.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 100,
                        height: 100,
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  builder: (context) => AppImageViewer(
                                        imageUR: e.file ?? "",
                                      ),
                                  context: context);
                            },
                            child: Image.network(e.file ?? "")),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
