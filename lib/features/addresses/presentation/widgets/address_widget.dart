import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/routes/app_routes.dart';
import 'package:shoplo_client/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:shoplo_client/widgets/app_loading.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/alert_dialogs/custom_alert_dialog.dart';
import '../../data/models/address_model.dart';

// This is the type used by the popup menu below.
enum Menu { shareAd, editAd, archiveAd, soldAd }

class AddressWidget extends StatefulWidget {
  final AddressModel address;

  const AddressWidget({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  AddressWidgetState createState() => AddressWidgetState();
}

class AddressWidgetState extends State<AddressWidget> {
  bool isFavorite = false;
  bool isDefault = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.all(10),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.address.title,
                  style: AppTextStyle.textStyleMediumGray,
                ),
                AppSizedBox.sizedH5,
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.textAppGray),
                    Text(
                      widget.address.address,
                      style: AppTextStyle.textStyleRegularGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.editAddress,
                            arguments: {"id": widget.address.id});
                      },
                      child: SvgPicture.asset(AppImages.svgEdit,
                          width: 20, height: 20)),
                  AppSizedBox.sizedW10,
                  InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocConsumer<AddressesCubit, AddressesState>(
                            listener: (context, state) {
                              AddressesCubit cubit =
                                  AddressesCubit.get(context);
                              if (state is DeleteAddressesErrorState &&
                                  cubit.currentItemId == widget.address.id) {
                                AppSnackBar.showError(state.error);
                              }
                              if (state is DeleteAddressesSuccessState &&
                                  cubit.currentItemId == widget.address.id) {
                                AppSnackBar.showSuccess(state.message);
                                // Future.delayed(
                                //     const Duration(milliseconds: 1000), () {
                                cubit.getAddresses();
                                // });
                                Navigator.of(context).pop(true);
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteAddressesLoadingState) {
                                return const AppLoading();
                              }
                              return CustomDialogBox(
                                title: context.tr.you_sure_deletet,
                                onPressedYes: () async {
                                  AddressesCubit.get(context)
                                      .deleteAddresses(widget.address.id);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      AppImages.svgDelete,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              Switch(
                value: widget.address.isPrimary,
                inactiveThumbColor: AppColors.gray.withOpacity(.3),
                inactiveTrackColor: AppColors.gray,
                onChanged: (bool value) {
                  // setState(() {
                  //   isDefault = value;
                  // });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
