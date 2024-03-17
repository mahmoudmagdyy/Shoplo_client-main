import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/config/constants.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/widgets/app_image.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_toast.dart';
import '../../../cart/data/models/cart.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

class ProductCartCard extends HookWidget {
  final CartModal cartData;
  final bool readOnly;
  const ProductCartCard({
    Key? key,
    required this.cartData,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState(cartData.quantity);
    final total = useState(double.parse(cartData.product.price));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.textAppWhiteDark,
          border: Border.all(
            color: AppColors.borderGrey,
            width: 1.5,
          ),
        ),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            CartCubit cubit = CartCubit.get(context);
            if (cubit.currentItemId == cartData.id) {
              if (state is UpdateItemErrorState) {
                AppToast.showToastError(state.error);
              } else if (state is UpdateItemSuccessState) {
                AppToast.showToastSuccess(context.tr.item_updated_successfully);
              }
            }
          },
          builder: (context, state) {
            CartCubit cartCubit = CartCubit.get(context);

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: context.width * .2,
                        height: context.width * .2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: AppImage(
                          imageURL: cartData.product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      AppSizedBox.sizedW10,
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cartData.product.name,
                              style: AppTextStyle.textStyleMediumAppBlack,
                            ),
                            SizedBox(
                              height: context.height * .01,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: context.width * .075,
                                  height: context.width * .075,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.textAppWhiteDark,
                                    border: Border.all(
                                      color: readOnly ? AppColors.grey : AppColors.textAppBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (readOnly) {
                                      } else {
                                        if (counter.value > 1) {
                                          cartCubit.updateItemInCart(
                                            cartData.id,
                                            counter.value - 1,
                                          );
                                          counter.value--;
                                        }
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                      "-",
                                      style: readOnly ? AppTextStyle.textStyleMediumGray : AppTextStyle.textStyleRegularAppBlack18,
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
                                      color: readOnly ? AppColors.grey : AppColors.textAppBlack,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (readOnly) {
                                      } else {
                                        if (counter.value < cartData.product.quantity) {
                                          cartCubit.updateItemInCart(
                                            cartData.id,
                                            counter.value + 1,
                                          );
                                          counter.value++;
                                        }
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                      "+",
                                      style: readOnly ? AppTextStyle.textStyleMediumGray : AppTextStyle.textStyleRegularAppBlack18,
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!readOnly)
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${(total.value * counter.value).toStringAsFixed(1)} ${CurrencyHelper.currencyString(context, nullableValue: cartData.product.currency)}",
                                style: AppTextStyle.textStyleMediumGold.copyWith(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () {
                                  cartCubit.deleteItemFromCart(cartData.id);
                                },
                                child: SvgPicture.asset(
                                  AppImages.svgDelete,
                                  color: AppColors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if ((state is UpdateItemLoadingState && cartCubit.currentItemId == cartData.id) ||
                    (state is DeleteItemLoadingState && cartCubit.currentItemId == cartData.id))
                  SizedBox(
                    width: double.infinity,
                    height: context.width * .28,
                    child: Center(
                      child: Container(
                        color: AppColors.primaryL.withOpacity(.4),
                        child: const AppLoading(
                          color: AppColors.primaryL,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
