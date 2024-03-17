import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../addresses/data/models/address_model.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({super.key, this.address, this.onAddressChanged});
  final AddressModel? address;
  final Function(AddressModel)? onAddressChanged;
  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  AddressModel? address;
  @override
  void initState() {
    address = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (address == null)
          AppTextFormField(
            label: context.tr.add_address,
            readOnly: true,
            onTap: () async {
              final result = await Navigator.of(context)
                  .pushNamed(AppRoutes.selectAddressScreen);
              if (result != null) {
                address = result as AddressModel;
                widget.onAddressChanged?.call(address!);
                setState(() {});
              }
            },
          ),
        if (address != null)
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                side:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1)),
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
                                address = result as AddressModel;
                                widget.onAddressChanged?.call(address!);
                                setState(() {});
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
                                "id": address?.id,
                              });
                              if (result != null) {
                                address = result as AddressModel;
                                widget.onAddressChanged?.call(address!);
                                setState(() {});
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
                        address!.title,
                        style: AppTextStyle.textStyleRegularAppBlack18,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedH5,
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      address!.address,
                      style: AppTextStyle.textStyleEditTextLabelRegularGray,
                    ),
                  ),
                  AppSizedBox.sizedH5,
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${address!.city.name} - ${address!.city.state.name} - ${address!.city.state.country.name}",
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
