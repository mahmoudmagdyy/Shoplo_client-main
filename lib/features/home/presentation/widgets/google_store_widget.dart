import 'package:flutter/material.dart';
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

class GoogleStorWidget extends StatefulWidget {
  final PlaceDetails store;

  const GoogleStorWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  GoogleStorWidgetState createState() => GoogleStorWidgetState();
}

class GoogleStorWidgetState extends State<GoogleStorWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (UserCubit.get(context).userData != null) {
          if (widget.store.isGoogleStore) {
            Navigator.of(context).pushNamed(
              AppRoutes.cartGoogleStoreScreen,
              arguments: widget.store,
            );
          } else {
            Navigator.of(context).pushNamed(
              AppRoutes.productsScreen,
              arguments: widget.store,
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => const LoginAlertDialog(),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 8,
          left: 16,
        ),
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
        child: Row(
          children: [
            if (widget.store.photos.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AppImage(
                  imageURL: widget.store.isGoogleStore
                      ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=120&photo_reference=${widget.store.photos[0]}&key=${MapConfiguration.apiKeyMaps}'
                      : widget.store.photos[0],
                  height: double.infinity,
                  width: 100,
                  fit: BoxFit.cover,
                  imageViewer: false,
                ),
              ),
            if (widget.store.photos.isEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AppImage(
                  imageURL: widget.store.icon,
                  height: 50,
                  width: 120,
                  fit: BoxFit.contain,
                  imageViewer: false,
                ),
              ),
            AppSizedBox.sizedW10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppSizedBox.sizedH10,
                  Text(
                    (widget.store.name),
                    style: AppTextStyle.textStyleMediumBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSizedBox.sizedH5,
                  Row(
                    children: [
                      Text(
                        widget.store.rating,
                        style: AppTextStyle.textStyleMediumGray12,
                      ),
                      AppSizedBox.sizedW5,
                      RatingBar.builder(
                        initialRating: double.parse(widget.store.rating),
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
                        '(${widget.store.userRatingsTotal})',
                        style: AppTextStyle.textStyleMediumGray12,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedH5,
                  // if (widget.store.types.isNotEmpty)
                  //   Text(
                  //     widget.store.types.toString(),
                  //     style: AppTextStyle.textStyleRegularGray,
                  //   ),
                  Text(
                    widget.store.address,
                    style: AppTextStyle.textStyleRegularGray
                        .copyWith(fontSize: 12),
                    maxLines: 2,
                  ),
                  Text(
                    widget.store.isOpen ? context.tr.open : context.tr.close,
                    style: AppTextStyle.textStyleRegularPrimary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
                  // Expanded(
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: AppButton(
                  //       width: 170,
                  //       height: 40,
                  //       onPressed: () {},
                  //       title: context.tr.order_now,
                  //     ),
                  //   ),
                  // ),
                  // AppSizedBox.sizedH5,
                ],
              ),
            ),
            AppSizedBox.sizedW10,
          ],
        ),
      ),
    );
  }
}
