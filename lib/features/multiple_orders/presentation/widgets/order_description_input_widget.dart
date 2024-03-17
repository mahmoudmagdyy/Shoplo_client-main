import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';
import 'package:shoplo_client/features/home/data/models/place_details.dart';
import 'package:shoplo_client/features/multiple_orders/presentation/cubit/multiple_orders_cubit.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../widgets/app_snack_bar.dart';
import '../../domain/request/create_mutiple_order_request.dart';
import 'map_dialog.dart';

class OrderDescriptionInputsWidget extends StatefulWidget {
  const OrderDescriptionInputsWidget({
    super.key,
    required this.order,
  });
  final OrderDescriptionModel order;
  @override
  State<OrderDescriptionInputsWidget> createState() =>
      _OrderDescriptionInputsWidgetState();
}

class _OrderDescriptionInputsWidgetState
    extends State<OrderDescriptionInputsWidget> {
  final TextEditingController address = TextEditingController();
  final TextEditingController orderDetails = TextEditingController();
  final TextEditingController expectedPrice = TextEditingController();

  @override
  void dispose() {
    address.dispose();
    orderDetails.dispose();
    expectedPrice.dispose();
    super.dispose();
  }

  @override
  void initState() {
    address.text = widget.order.storeAddress;
    orderDetails.text = widget.order.notes;
    expectedPrice.text = widget.order.subtotal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = MultipleOrdersCubit.get(context);
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: InkWell(
              onTap: () async {
                if (cubit.createRequest.fromCity == null) {
                  AppSnackBar.showError(context.tr.should_choose_city_first);
                  return;
                }
                final place = await showDialog<PlaceDetails>(
                    context: context,
                    builder: (context) => MapDialog(
                        latLng: LatLng(
                            cubit.createRequest.fromCity!.latitude.toDouble ??
                                0,
                            cubit.createRequest.fromCity!.longitude.toDouble ??
                                0),
                        city: cubit.createRequest.fromCity!.id.toString()));
                if (place != null) {
                  address.text = place.name;
                  address.text += '\n${place.address}';
                  widget.order.storeAddress = address.text;
                  widget.order.storeLat = place.lat.toString();
                  widget.order.storeLng = place.lng.toString();
                  widget.order.storeName = place.name;
                  if (place.photos.isNotEmpty) {
                    widget.order.storeImage = place.photos[0].toString();
                  } else {
                    widget.order.storeImage = place.icon.toString();
                  }
                }
                setState(() {});
              },
              child: Row(children: [
                SvgPicture.asset(
                  AppImages.map,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 5),
                Text(context.tr.select_store_location,
                    style: AppTextStyle.textStyleMediumGray12
                        .copyWith(fontSize: 13)),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AppTextFormField(
                    maxLine: 2,
                    controller: address,
                    readOnly: widget.order.storeLat.isEmpty,
                    onChanged: (s) {
                      widget.order.storeAddress = s;
                    },
                    keyboardType: TextInputType.multiline,
                    label: context.tr.write_address),
                AppTextFormField(
                    maxLine: 2,
                    controller: orderDetails,
                    onChanged: (s) {
                      widget.order.notes = s;
                    },
                    keyboardType: TextInputType.multiline,
                    label: context.tr.order_details),
                SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                          width: 120,
                          child: AppTextFormField(
                              isDense: true,
                              controller: expectedPrice,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              keyboardType: TextInputType.number,
                              style: AppTextStyle.textStyleMediumGray12
                                  .copyWith(fontSize: 12),
                              onChanged: (s) {
                                widget.order.subtotal = s;
                                cubit.refreshFields(s);
                              },
                              label: context.tr.expected_price)),
                      const Expanded(child: SizedBox(width: 10)),
                      SizedBox(
                        width: 80,
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                  backgroundColor: AppColors.backgroundGray2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                cubit.removeOrderDescription(widget.order);
                              },
                              child: Text(
                                context.tr.remove,
                                style: AppTextStyle.textStyleRegularBlack
                                    .copyWith(fontSize: 12),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ]));
  }
}
