import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/services/injection.dart';

import '../../../../resources/images/images.dart';
import '../../../../widgets/alert_dialogs/login_alert_dialog.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/app_toast.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../cubit/cart_cubit.dart';

class AddToCartWidget extends StatelessWidget {
  final int id;
  final int count;
  final bool onCard;

  const AddToCartWidget(
      {super.key, required this.id, required this.count, this.onCard = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        CartCubit cartCubit = CartCubit.get(context);
        if (cartCubit.currentItemId == id) {
          if (state is AddToCartErrorState) {
            AppToast.showToastError(state.error);
          } else if (state is AddToCartLoadedState) {
            AppToast.showToastSuccess(context.tr.added_successfully);
          }
        }
      },
      builder: (context, state) {
        CartCubit cartCubit = CartCubit.get(context);

        if (onCard) {
          if (state is AddToCartLoadingState && cartCubit.currentItemId == id) {
            return const AppLoading(
              scale: .4,
            );
          } else {
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (UserCubit.get(context).userData == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const LoginAlertDialog(),
                  );
                } else {
                  cartCubit.addToCart(
                    id,
                    {
                      "product_id": id,
                      "quantity": 1,
                    },
                  );
                }
              },
              icon: SvgPicture.asset(
                AppImages.cart1,
                width: 20,
                height: 20,
              ),
            );
          }
        } else {
          return AppButton(
            width: context.width * .7,
            onPressed: () {
              if (UserCubit.get(context).userData == null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const LoginAlertDialog(),
                );
              } else {
                serviceLocator.get<CartCubit>();
                cartCubit.addToCart(
                  id,
                  {
                    "product_id": id,
                    "quantity": count,
                  },
                );
              }
            },
            loading:
                state is AddToCartLoadingState && cartCubit.currentItemId == id,
            title: context.tr.add_to_cart,
          );
        }
      },
    );
  }
}
