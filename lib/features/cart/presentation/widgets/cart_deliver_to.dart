import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../home/presentation/cubit/location_cubit.dart';
import '../../../my_orders/data/models/order.dart';

class CartDeliverToWidget extends StatelessWidget {
  final OrderModel order;
  const CartDeliverToWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizedBox.sizedH10,
            Text(
              '${context.tr.deliver_to} : ',
              style: AppTextStyle.textStyleRegularGrayLight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.textAppGray),
                    Text(
                      order.userAddress?.address ?? "",
                      style: AppTextStyle.textStyleRegularBlack,
                    ),
                  ],
                ),
                if (order.status.key == "new" || order.status.key == 'delivering' || order.status.key == "delivered")
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.route_rounded, color: AppColors.textAppGray),
                    onPressed: () async {
                      String googleUrl =
                          'https://www.google.com/maps/dir/?api=1&travelmode=driving&dir_action=navigate&origin=${context.read<LocationCubit>().latLng.latitude},${context.read<LocationCubit>().latLng.longitude}&destination=${order.storeLat},${order.storeLong}';
                      debugPrint('googleUrl $googleUrl');
                      if (await launchUrlString(
                        googleUrl,
                        mode: LaunchMode.externalApplication,
                      )) {
                        await launchUrlString(
                          googleUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        throw 'Could not open the map.';
                      }
                    },
                  ),
              ],
            ),
            AppSizedBox.sizedH5,
            Text(
              '${context.tr.delivery} : ',
              style: AppTextStyle.textStyleRegularGrayLight,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.car,
                  width: 20,
                  height: 30,
                  matchTextDirection: true,
                ),
                AppSizedBox.sizedW10,
                Expanded(
                  child: Text(
                    '${context.tr.from} : ${order.deliveryDate}\n${context.tr.to} : ${order.deliveryDateTo}',
                    style: AppTextStyle.textStyleRegularBlack,
                  ),
                ),
              ],
            ),
            AppSizedBox.sizedH15,
          ],
        ),
      ),
    );
  }
}
