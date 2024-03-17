import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/addresses/data/models/address_model.dart';
import 'package:shoplo_client/features/layout/presentation/cubit/user/user_cubit.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../cubit/cart_cubit.dart';

class CartAddressWidget extends HookWidget {
  final TextEditingController controller;

  const CartAddressWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = UserCubit.get(context);
    CartCubit cartCubit = CartCubit.get(context);

    final selected = useState(cartCubit.cartAddress ??
        (userCubit.userData!.user.addresses.isNotEmpty
            ? userCubit.userData!.user.addresses[0]
            : null));

    return Column(
      children: [
        if (selected.value == null)
          AppTextFormField(
            label: context.tr.add_address,
            controller: controller,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed(AppRoutes.selectAddressScreen);
              if (result != null) {
                AddressModel address = result as AddressModel;
                controller.text = address.id.toString();
                selected.value = address;
                cartCubit.setCartAddress(address);
              }
            },
          ),
        if (selected.value != null)
          Card(
            elevation: 5,
            color: AppColors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.padding15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.sizedH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.tr.deliver_to,
                        style: AppTextStyle.textStyleRegularGrayLight,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.of(context)
                                  .pushNamed(AppRoutes.selectAddressScreen);
                              if (result != null) {
                                AddressModel address = result as AddressModel;
                                controller.text = address.id.toString();
                                selected.value = address;
                                cartCubit.setCartAddress(address);
                              }
                            },
                            child: Text(
                              context.tr.change,
                              style: AppTextStyle.textStyleMediumPrimary,
                            ),
                          ),
                          AppSizedBox.sizedW20,
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.of(context)
                                  .pushNamed(AppRoutes.editAddress, arguments: {
                                "id": selected.value!.id,
                              });
                              if (result != null) {
                                AddressModel address = result as AddressModel;
                                controller.text = address.id.toString();
                                selected.value = address;
                                cartCubit.setCartAddress(address);
                              }
                            },
                            child: SvgPicture.asset(
                              AppImages.svgEdit,
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSizedBox.line,
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.textAppGray),
                      Text(
                        selected.value!.title,
                        style: AppTextStyle.textStyleRegularAppBlack18,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedH5,
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      selected.value!.address,
                      style: AppTextStyle.textStyleEditTextLabelRegularGray,
                    ),
                  ),
                  AppSizedBox.sizedH5,
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${selected.value!.city.name} - ${selected.value!.city.state.name} - ${selected.value!.city.state.country.name}",
                      style: AppTextStyle.textStyleEditTextLabelRegularGray,
                    ),
                  ),
                  AppSizedBox.sizedH15,
                ],
              ),
            ),
          ),
      ],
    );
  }
}
