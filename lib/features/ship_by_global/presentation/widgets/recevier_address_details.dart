import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/features/addresses/domain/entities/city.dart';
import 'package:shoplo_client/resources/colors/colors.dart';
import 'package:shoplo_client/resources/images/images.dart';
import 'package:shoplo_client/widgets/form_field/text_form_field.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../widgets/app_toast.dart';
import '../../../../widgets/form_field/autocomplate.dart';
import '../../../../widgets/form_field/date_time_picker.dart';
import '../../../addresses/data/models/address_model.dart';
import '../../../addresses/domain/entities/country.dart';
import '../../../addresses/domain/entities/state.dart';
import '../../domain/entities/ship_by_global.dart';
import '../cubit/ship_by_global_cubit.dart';

class ReceiverAddressDetails extends HookWidget {
  const ReceiverAddressDetails(
    this.shipByGlobalEntity, {
    super.key,
  });
  final ShipByGlobalEntity shipByGlobalEntity;
  @override
  Widget build(BuildContext context) {
    final cubit = ShipByGlobalCubit.get(context);
    final address = useState<AddressModel?>(null);
    final country = useTextEditingController();
    final city = useTextEditingController();
    final state = useTextEditingController();
    final addressController = useTextEditingController();
    final countryId = useState<Country?>(null);
    final stateId = useState<int?>(null);
    final dateFrom = useState(DateTime.now());
    final cityId = useState<int?>(null);

    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          title: Text(context.tr.receiver_address),
          trailing: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(50, 20),
              foregroundColor: AppColors.primaryL,
              side: const BorderSide(color: AppColors.primaryL),
            ),
            onPressed: () async {
              final result = await Navigator.of(context)
                  .pushNamed(AppRoutes.selectAddressScreen);
              if (result != null) {
                address.value = result as AddressModel;
                if (result.latitude ==
                        shipByGlobalEntity.senderAddress.latitude &&
                    result.longitude ==
                        shipByGlobalEntity.senderAddress.longitude) {
                  AppToast.showToastError(
                      context.tr.cannot_choose_same_address);
                  return;
                }
                country.text = address.value!.city.state.country.name;
                state.text = address.value!.city.state.name;
                city.text = address.value!.city.name;

                addressController.text = address.value!.address;
                shipByGlobalEntity.receiverAddress.address =
                    address.value!.address;
                shipByGlobalEntity.receiverAddress.city = address.value!.city;
                shipByGlobalEntity.receiverAddress.latitude =
                    address.value!.latitude;
                shipByGlobalEntity.receiverAddress.longitude =
                    address.value!.longitude;
                cityId.value = address.value!.city.id;
                stateId.value = address.value!.city.state.id;
                countryId.value = address.value!.city.state.country;
                shipByGlobalEntity.receiverCountry = countryId.value?.id;
              }
            },
            child: Text(context.tr.saved_addresses),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppAutoCompleteDropDown<Country>(
                  label: context.tr.country,
                  searchInApi: false,
                  controller: country,
                  showSufix: true,
                  onChanged: (p0) {
                    countryId.value = p0;
                    shipByGlobalEntity.receiverCountry = countryId.value?.id;
                    shipByGlobalEntity.receiverAddress.latitude = null;
                    shipByGlobalEntity.receiverAddress.longitude = null;
                    cityId.value = null;
                    stateId.value = null;
                    city.clear();
                    state.clear();
                  },
                  itemAsString: (s) => s.name,
                  function: (p0) async => (await cubit.geCountry()) ?? [],
                  validator: (s) {
                    if (s == null || s.isEmpty) {
                      return context.tr.required;
                    }
                    return null;
                  }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IgnorePointer(
                ignoring: countryId.value == null,
                child: AppAutoCompleteDropDown<StateEntity>(
                    label: context.tr.state,
                    showSufix: true,
                    refreshOnTap: true,
                    controller: state,
                    searchInApi: false,
                    onChanged: (p0) {
                      stateId.value = p0.id;
                      cityId.value = null;
                      shipByGlobalEntity.receiverAddress.latitude = null;
                      shipByGlobalEntity.receiverAddress.longitude = null;
                      city.clear();
                    },
                    itemAsString: (s) => s.name,
                    function: (p0) async =>
                        (await cubit.getStates(countryId.value?.id ?? 0)) ?? [],
                    validator: (s) {
                      if (s == null || s.isEmpty) {
                        return context.tr.required;
                      }
                      return null;
                    }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        IgnorePointer(
          ignoring: stateId.value == null,
          child: AppAutoCompleteDropDown<City>(
              label: context.tr.city,
              showSufix: true,
              refreshOnTap: true,
              controller: city,
              searchInApi: false,
              onChanged: (p0) {
                shipByGlobalEntity.receiverAddress.city = p0;
                cityId.value = p0.id;
                shipByGlobalEntity.receiverAddress.latitude = null;
                shipByGlobalEntity.receiverAddress.longitude = null;
              },
              itemAsString: (s) => s.name,
              function: (p0) async => await cubit.getCity(stateId.value!) ?? [],
              validator: (s) {
                if (s == null || s.isEmpty) {
                  return context.tr.required;
                }
                return null;
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  controller: addressController,
                  label: context.tr.write_address,
                  maxLine: 3,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () async {
                    if (shipByGlobalEntity.receiverAddress.city == null) {
                      return;
                    }
                    final result = await Navigator.of(context)
                        .pushNamed(AppRoutes.mapSearchScreen, arguments: {
                      "LatLng": LatLng(
                        double.parse(
                            shipByGlobalEntity.receiverAddress.city!.latitude),
                        double.parse(
                            shipByGlobalEntity.receiverAddress.city!.longitude),
                      ),
                      "country": countryId.value?.code,
                    });
                    if (result != null) {
                      Map<String, dynamic> result1 =
                          result as Map<String, dynamic>;
                      if (result1.isNotEmpty) {
                        print(result1);
                        debugPrint("callback location address $result1");
                        addressController.text = result1["text"];
                        shipByGlobalEntity.receiverAddress.address =
                            result1["text"];
                        shipByGlobalEntity.receiverAddress.latitude =
                            result1["lat"].toString();
                        shipByGlobalEntity.receiverAddress.longitude =
                            result1["lng"].toString();
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppImages.storeLocation,
                        width: 25, height: 25),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  label: context.tr.receiver_name,
                  onChanged: (p0) {
                    shipByGlobalEntity.receiverAddress.name = p0;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppTextFormField(
                  label: context.tr.id_number,
                  validator: (p0) => null,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    shipByGlobalEntity.receiverAddress.idNumber = p0;
                  },
                ),
              ),
            ],
          ),
        ),
        AppTextFormField(
          label: context.tr.phone_number,
          keyboardType: TextInputType.number,
          onChanged: (p0) {
            shipByGlobalEntity.receiverAddress.phone = p0;
          },
        ),
        CustomDateAndTimePicker(
          label: context.tr.from,
          onChanged: (p0) {
            if (p0 != null) {
              dateFrom.value = p0;
            }
            shipByGlobalEntity.deliveryDate = p0.toString();
          },
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return context.tr.required;
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        CustomDateAndTimePicker(
          label: context.tr.to,
          startDate: dateFrom.value,
          onChanged: (p0) {
            shipByGlobalEntity.deliveryDateTo = p0.toString();
          },
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return context.tr.required;
            }
            return null;
          },
        ),
      ],
    );
  }
}
