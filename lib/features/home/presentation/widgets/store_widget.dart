import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/config/map_config.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../data/models/place_details.dart';

// This is the type used by the popup menu below.
enum Menu { shareAd, editAd, archiveAd, soldAd }

class StorWidget extends HookWidget {
  final PlaceDetails store;
  const StorWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return Card(
      child: Container(
        // margin: const EdgeInsets.only(
        //   bottom: 8,
        //   left: 16,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            if (store.photos.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: AppImage(
                  imageURL: store.isGoogleStore
                      ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=120&photo_reference=${store.photos[0]}&key=${MapConfiguration.apiKeyMaps}'
                      : store.photos[0],
                  width: double.infinity,
                  height: context.width * .4,
                  fit: BoxFit.cover,
                  imageViewer: false,
                ),
              ),
            if (store.photos.isEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AppImage(
                  imageURL: store.icon,
                  width: double.infinity,
                  height: context.width * .4,
                  fit: BoxFit.contain,
                  imageViewer: false,
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: AppTextStyle.textStyleMediumBlack,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSizedBox.sizedH5,
                    Row(
                      children: [
                        Text(
                          store.rating,
                          style: AppTextStyle.textStyleMediumGray12,
                        ),
                        AppSizedBox.sizedW5,
                        RatingBar.builder(
                          initialRating: double.parse(store.rating),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 13,
                          ignoreGestures: true,
                          unratedColor: AppColors.gray,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 3,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        AppSizedBox.sizedW5,
                        Text(
                          '(${store.userRatingsTotal})',
                          style: AppTextStyle.textStyleMediumGray12,
                        ),
                      ],
                    ),
                    AppSizedBox.sizedH5,
                    // if (store.types.isNotEmpty)
                    //   Text(
                    //     store.types.toString(),
                    //     style: AppTextStyle.textStyleRegularGray,
                    //   ),
                    if (store.address.isNotEmpty)
                      Text(
                        store.address,
                        style: AppTextStyle.textStyleRegularGray,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Text(
                      store.isOpen ? context.tr.open : context.tr.close,
                      style: AppTextStyle.textStyleRegularPrimary,
                    ),
                    // const Text(
                    //   'Close at midnight',
                    //   style: AppTextStyle.textStyleRegularGray,
                    // ),
                    // const Text(
                    //   '\$3 per Meal',
                    //   style: AppTextStyle.textStyleRegularGold,
                    // ),
                    // AppSizedBox.sizedW5,
                    // const Text(
                    //   '(24 meals available)',
                    //   style: AppTextStyle.textStyleRegularGray,
                    // ),
                    AppSizedBox.sizedH5,
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AppButton(
                          width: 170,
                          height: 40,
                          onPressed: () {
                            if (UserCubit.get(context).userData != null) {
                              if (store.isGoogleStore) {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.cartGoogleStoreScreen,
                                  arguments: store,
                                );
                              } else {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.productsScreen,
                                  arguments: store,
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LoginAlertDialog(),
                              );
                            }
                          },
                          title: context.tr.order_now,
                        ),
                      ),
                    ),
                    // AppSizedBox.sizedH5,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
