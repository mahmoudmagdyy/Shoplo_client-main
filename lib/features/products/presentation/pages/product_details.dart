import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/network/presentation/pages/network_sensitive.dart';
import 'package:shoplo_client/features/products/presentation/cubit/product_details_cubit.dart';
import 'package:shoplo_client/resources/styles/app_text_style.dart';
import 'package:shoplo_client/widgets/app_conditional_widget.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../widgets/app_swiper.dart';
import '../../../cart/presentation/widgets/add_to_cart.dart';
import '../../data/models/product.dart';
import '../../data/models/product_details.dart';

class ProductDetails extends HookWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final counter = useState(1);
    final total = useState(double.parse(product.price));

    return Scaffold(
      appBar: appAppBar(context, product.name),
      body: NetworkSensitive(
        child: BlocProvider(
          create: (context) => ProductDetailsCubit()..getProductDetails(product.id),
          child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return AppConditionalBuilder(
                emptyCondition: state is GetProductDetailsSuccessState && state.productDetails == null,
                errorCondition: state is GetProductDetailsErrorState,
                errorMessage: state is GetProductDetailsErrorState ? state.error : '',
                loadingCondition: state is GetProductDetailsLoadingState,
                successCondition: state is GetProductDetailsSuccessState,
                successBuilder: (context) {
                  if (state is GetProductDetailsSuccessState) {
                    ProductDetailsModal productDetails = state.productDetails;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: AppSwiper(
                              slider: [
                                Attachments(
                                  id: 100,
                                  name: '',
                                  file: productDetails.image,
                                  folder: 'folder',
                                  type: 'type',
                                  description: 'description',
                                ),
                                ...productDetails.attachments,
                              ],
                            ),
                          ),
                          AppSizedBox.sizedH10,
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productDetails.name,
                                  style: AppTextStyle.textStyleSemiBoldGold,
                                ),
                                AppSizedBox.sizedH5,
                                // Row(
                                //   children: [
                                //     const Text(
                                //       '4.5',
                                //       style: AppTextStyle.textStyleRegularGray,
                                //     ),
                                //     AppSizedBox.sizedW5,
                                //     RatingBar.builder(
                                //       initialRating: 4.5,
                                //       minRating: 1,
                                //       direction: Axis.horizontal,
                                //       allowHalfRating: true,
                                //       itemCount: 5,
                                //       itemSize: 15,
                                //       unratedColor: AppColors.gray,
                                //       itemPadding: const EdgeInsets.symmetric(
                                //           horizontal: 1.0),
                                //       itemBuilder: (context, _) => const Icon(
                                //         Icons.star_rounded,
                                //         color: Colors.amber,
                                //         size: 3,
                                //       ),
                                //       onRatingUpdate: (rating) {},
                                //     ),
                                //   ],
                                // ),
                                // AppSizedBox.sizedH5,
                                AppSizedBox.line,
                                AppSizedBox.sizedH5,
                                Text(
                                  context.tr.description,
                                  style: AppTextStyle.textStyleRegularGrayLight,
                                ),
                                AppSizedBox.sizedH5,
                                Text(
                                  productDetails.description,
                                  style: AppTextStyle.textStyleRegularBlack,
                                ),
                                AppSizedBox.sizedH10,
                                AppSizedBox.line,
                                AppSizedBox.sizedH5,
                                Text(
                                  context.tr.price,
                                  style: AppTextStyle.textStyleRegularGrayLight,
                                ),
                                AppSizedBox.sizedH5,
                                Text(
                                  productDetails.price,
                                  style: AppTextStyle.textStyleRegularBlack,
                                ),
                                AppSizedBox.sizedH10,
                                AppSizedBox.line,
                                Text(
                                  context.tr.quantity,
                                  style: AppTextStyle.textStyleRegularGrayLight,
                                ),
                                AppSizedBox.sizedH10,
                                Row(
                                  children: [
                                    Container(
                                      width: context.width * .075,
                                      height: context.width * .075,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.textAppWhiteDark,
                                        border: Border.all(
                                          color: AppColors.textAppBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          if (counter.value > 0) {
                                            counter.value--;
                                          }
                                        },
                                        child: const Center(
                                            child: Text(
                                          "-",
                                          style: AppTextStyle.textStyleRegularAppBlack18,
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
                                      child: Text(
                                        counter.value.toString(),
                                        style: AppTextStyle.textStyleRegularAppBlack18,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: context.width * .075,
                                      height: context.width * .075,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.textAppWhiteDark,
                                        border: Border.all(
                                          color: AppColors.textAppBlack,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          if (counter.value < productDetails.quantity) {
                                            counter.value++;
                                          }
                                        },
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: AppTextStyle.textStyleRegularAppBlack18,
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                AppSizedBox.sizedH20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(context.tr.total),
                                        Text(
                                          "${(total.value * counter.value).toString()} ${CurrencyHelper.currencyString(context, nullableValue: product.currency)}",
                                          style: AppTextStyle.textStyleMediumGold.copyWith(
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    AddToCartWidget(
                                      id: productDetails.id,
                                      count: counter.value,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                errorBuilder: (BuildContext context) {
                  if (state is GetProductDetailsErrorState) {
                    return Center(child: Text(state.error));
                  } else {
                    return Container();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
