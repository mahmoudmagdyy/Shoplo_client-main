import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shoplo_client/features/addresses/data/models/address_model.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';

class SelectAddressWidget extends HookWidget {
  final AddressModel address;

  const SelectAddressWidget({super.key, required this.address});

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
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(address);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.padding15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBox.sizedH10,
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.textAppGray),
                  Text(
                    address.title,
                    style: AppTextStyle.textStyleRegularAppBlack18,
                  ),
                ],
              ),
              AppSizedBox.sizedH5,
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  address.address,
                  style: AppTextStyle.textStyleEditTextLabelRegularGray,
                ),
              ),
              AppSizedBox.sizedH5,
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  "${address.city.name} - ${address.city.state.name} - ${address.city.state.country.name}",
                  style: AppTextStyle.textStyleEditTextLabelRegularGray,
                ),
              ),
              AppSizedBox.sizedH15,
            ],
          ),
        ),
      ),
    );
  }
}
