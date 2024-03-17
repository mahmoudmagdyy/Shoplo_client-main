import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/app_image.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_toast.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../data/models/product.dart';

class NewProductWidget extends StatefulWidget {
  const NewProductWidget({super.key, required this.product});
  final ProductModel product;

  @override
  State<NewProductWidget> createState() => _NewProductWidgetState();
}

class _NewProductWidgetState extends State<NewProductWidget> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: AppColors.backgroundGray,
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.productDetailsScreen,
            arguments: widget.product,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: AppColors.backgroundGray,
                clipBehavior: Clip.hardEdge,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: AppImage(
                  imageURL: widget.product.image,
                  width: 70,
                  fit: BoxFit.contain,
                  height: 70,
                  imageViewer: false,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                //name
                Text(widget.product.name, style: AppTextStyle.textStyleTitle.copyWith(fontSize: 16)),
                const SizedBox(height: 5),
                //price
                Text(
                  '${widget.product.price} ${CurrencyHelper.currencyString(context, nullableValue: widget.product.currency)}',
                  style: AppTextStyle.textStyleTitle.copyWith(fontSize: 14, color: AppColors.textAppGold),
                ),
                //count
                BlocConsumer<CartCubit, CartState>(listener: (context, state) {
                  CartCubit cartCubit = CartCubit.get(context);
                  if (state is AddToCartErrorState) {
                    AppToast.showToastError(state.error);
                  } else if (state is AddToCartLoadedState) {
                    AppToast.showToastSuccess(context.tr.added_successfully);
                  } else if (state is UpdateItemErrorState) {
                    AppToast.showToastError(state.error);
                  } else if (state is UpdateItemSuccessState) {
                    AppToast.showToastSuccess(context.tr.update_successfully);
                  }
                }, builder: (context, state) {
                  CartCubit cartCubit = CartCubit.get(context);
                  final cartProduct = cartCubit.cart.getProduct(widget.product.id);
                  count = cartProduct != null ? cartProduct.quantity : 1;
                  return Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ProductCountWidget(
                            count: cartProduct != null ? cartProduct.quantity : 1,
                            onCountChanged: (count) {
                              this.count = count;
                              print(this.count);
                            },
                          ),
                        ),
                      ),
                      //add to cart

                      SizedBox(
                        height: 30,
                        child: Builder(builder: (context) {
                          CartCubit cartCubit = CartCubit.get(context);

                          return state is AddToCartLoadingState && cartCubit.currentItemId == widget.product.id
                              ? const AppLoading(
                                  scale: .3,
                                )
                              : InkWell(
                                  onTap: () {
                                    if (UserCubit.get(context).userData == null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => const LoginAlertDialog(),
                                      );
                                    } else {
                                      if (cartProduct != null && cartProduct.quantity == count) {
                                        return;
                                      }
                                      if (cartProduct != null && cartProduct.quantity != count) {
                                        cartCubit.updateItemInCart(
                                          cartProduct.id,
                                          count,
                                        );
                                        return;
                                      }

                                      if (cartProduct == null) {
                                        cartCubit.addToCart(
                                          widget.product.id,
                                          {
                                            "product_id": widget.product.id,
                                            "quantity": count,
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.addToCart),
                                      const SizedBox(width: 5),
                                      Text(context.tr.add_to_cart,
                                          style: AppTextStyle.textStyleTitle.copyWith(fontSize: 12, color: AppColors.textBlue)),
                                    ],
                                  ),
                                );
                        }),
                      ),
                      const SizedBox(width: 5),
                    ],
                  );
                })
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class ProductCountWidget extends StatefulWidget {
  const ProductCountWidget({
    super.key,
    this.onCountChanged,
    required this.count,
  });
  final Function(int)? onCountChanged;
  final int count;
  @override
  State<ProductCountWidget> createState() => _ProductCountWidgetState();
}

class _ProductCountWidgetState extends State<ProductCountWidget> {
  int count = 1;
  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: 0,
          color: AppColors.backgroundGray2,
          child: InkWell(
            onTap: () {
              count = count + 1;
              widget.onCountChanged?.call(count);

              setState(() {});
            },
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.add,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          count.toString(),
          style: AppTextStyle.textStyleTitle.copyWith(fontSize: 14),
        ),
        const SizedBox(width: 5),
        Card(
          elevation: 0,
          color: AppColors.backgroundGray2,
          child: InkWell(
            onTap: () {
              count = count == 1 ? 1 : count - 1;
              setState(() {});
              widget.onCountChanged?.call(count);
            },
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.remove,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
