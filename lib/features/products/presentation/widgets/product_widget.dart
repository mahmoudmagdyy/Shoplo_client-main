import 'package:flutter/material.dart';
import 'package:shoplo_client/features/cart/presentation/widgets/add_to_cart.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../data/models/product.dart';

// This is the type used by the popup menu below.
enum Menu { shareAd, editAd, archiveAd, soldAd }

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  ProductWidgetState createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Container(
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
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.productDetailsScreen,
                        arguments: widget.product,
                      );
                    },
                    child: AppImage(
                      imageURL: widget.product.image,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageViewer: false,
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cartBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: AddToCartWidget(
                          id: widget.product.id,
                          count: 1,
                          onCard: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSizedBox.sizedH10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: AppTextStyle.textStyleMediumAppBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.textAppGold,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.product.price} ${CurrencyHelper.currencyString(context, nullableValue: widget.product.currency)}',
                    style: AppTextStyle.textStyleRegularGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
