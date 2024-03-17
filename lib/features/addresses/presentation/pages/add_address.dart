import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';
import 'package:shoplo_client/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:shoplo_client/widgets/app_snack_bar.dart';
import 'package:shoplo_client/widgets/app_toast.dart';
import 'package:shoplo_client/widgets/shoplo/app_app_bar.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_loading.dart';
import '../../../../widgets/form_field/location_form_field.dart';
import '../../../../widgets/form_field/text_form_field.dart';
import '../../../layout/presentation/cubit/user/user_cubit.dart';
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/state.dart';
import '../cubit/city/city_cubit.dart';
import '../cubit/country/country_cubit.dart';
import '../cubit/state/state_cubit.dart';
import '../widgets/switch_button.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen> {
  final _form = GlobalKey<FormState>();
  final _dropdownStateCountries = GlobalKey<FormFieldState>();
  final _dropdownStateStates = GlobalKey<FormFieldState>();
  final _dropdownStateCities = GlobalKey<FormFieldState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController streetDetails = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  String addressType = "home";
  String countryCode = "";
  LatLng? latLng;
  bool isDefault = false;

  @override
  void initState() {
    super.initState();
    CountriesCubit.get(context).resetCubit();
    StateCubit.get(context).resetCubit();
    CityCubit.get(context).resetCubit();
    CountriesCubit.get(context).getCountries();
    UserCubit userCubit = UserCubit.get(context);
    // name.text =
    //     (userCubit.userData != null ? userCubit.userData!.user.name : '');
    email.text = (userCubit.userData != null ? userCubit.userData!.user.email : '');
    phone.text = (userCubit.userData != null ? userCubit.userData!.user.phone : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(context, context.tr.add_address),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Form(
                  key: _form,
                  child: AutofillGroup(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppTextFormField(controller: name, label: context.tr.name),
                        const HeightSpace(),
                        AppTextFormField(
                          controller: phone,
                          label: context.tr.mobile_num,
                          keyboardType: TextInputType.number,
                        ),
                        // PhoneTextFormField(
                        //   controller: phone,
                        //   onSelect: (val) {
                        //     countryCode = val;
                        //   },
                        // ),
                        const HeightSpace(),
                        AppTextFormField(controller: email, label: context.tr.email),
                        const HeightSpace(),

                        BlocBuilder<CountriesCubit, CountriesState>(
                          builder: (context, state) {
                            return DropdownButtonFormField<Country>(
                              key: _dropdownStateCountries,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              items: CountriesCubit.get(context).countries.map(buildMenuItemCountriesModel).toList(),
                              value: CountriesCubit.get(context).countriesModel,
                              dropdownColor: AppColors.white,
                              style: AppTextStyle.textStyleEditTextValueRegularBlack,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.textAppGray, width: .5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.gray,
                                size: 25,
                              ),
                              hint: state is CountriesLoadingStateNew
                                  ? const AppLoading(
                                      scale: .4,
                                      color: AppColors.primaryL,
                                    )
                                  : Text(
                                      context.tr.country,
                                      style: AppTextStyle.textStyleRegularGray,
                                    ),
                              onChanged: (newVal) {
                                CountriesCubit.get(context).setSelectedCountriesModel(newVal!);
                                StateCubit.get(context).getStates(newVal.id);
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return context.tr.required_field;
                                }
                              },
                            );
                          },
                        ),
                        const HeightSpace(),
                        BlocBuilder<StateCubit, StateState>(
                          builder: (context, state) {
                            return DropdownButtonFormField<StateEntity>(
                              key: _dropdownStateStates,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              items: StateCubit.get(context).states.map(buildMenuItemStatesModel).toList(),
                              value: StateCubit.get(context).statesModel,
                              dropdownColor: AppColors.white,
                              style: AppTextStyle.textStyleEditTextValueRegularBlack,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.textAppGray, width: .5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.gray,
                                size: 25,
                              ),
                              hint: state is StatesLoadingStateNew
                                  ? const AppLoading(
                                      scale: .4,
                                      color: AppColors.primaryL,
                                    )
                                  : Text(
                                      context.tr.state,
                                      style: AppTextStyle.textStyleRegularGray,
                                    ),
                              onChanged: (newVal) {
                                StateCubit.get(context).setSelectedStatesModel(newVal!);
                                CityCubit.get(context).getCites(newVal.id);
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return context.tr.required_field;
                                }
                              },
                            );
                          },
                        ),
                        const HeightSpace(),
                        BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                            return DropdownButtonFormField<City>(
                              key: _dropdownStateCities,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              items: CityCubit.get(context).cites.map(buildMenuItemCities).toList(),
                              value: CityCubit.get(context).citiesModel,
                              dropdownColor: AppColors.white,
                              style: AppTextStyle.textStyleEditTextValueRegularBlack,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.textAppGray, width: .5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.gray,
                                size: 25,
                              ),
                              hint: state is CitiesLoadingStateNew
                                  ? const AppLoading(
                                      scale: .4,
                                      color: AppColors.primaryL,
                                    )
                                  : Text(
                                      context.tr.city,
                                      style: AppTextStyle.textStyleRegularGray,
                                    ),
                              onChanged: (newVal) {
                                CityCubit.get(context).setSelectedCitesModel(newVal!);
                                setState(() {});
                              },
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                } else {
                                  return context.tr.required_field;
                                }
                              },
                            );
                          },
                        ),
                        const HeightSpace(),
                        if (CityCubit.get(context).citiesModel != null)
                          LocationTextFormField(
                            readOnly: true,
                            controller: address,
                            label: context.tr.address,
                            latLng:
                                LatLng(CityCubit.get(context).citiesModel!.latitude.toDouble, CityCubit.get(context).citiesModel!.longitude.toDouble),
                            onDetectLocation: (val) {
                              latLng = val;
                            },
                          ),
                        const HeightSpace(),
                        // Row(
                        //   children: [
                        //     Text(
                        //       context.tr.address_type,
                        //       style: AppTextStyle.textStyleRegularGray,
                        //     ),
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     RadioListTile(
                        //       title: Text(context.tr.home1),
                        //       value: 'home',
                        //       groupValue: addressType,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           addressType = value.toString();
                        //         });
                        //       },
                        //     ),
                        //     RadioListTile(
                        //       title: Text(context.tr.office),
                        //       value: 'office',
                        //       groupValue: addressType,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           addressType = value.toString();
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                        SwitchButton(
                            name: context.tr.use_as_default_address,
                            onVal: (val) {
                              setState(() {
                                isDefault = val;
                              });
                            }),
                        BlocConsumer<AddressesCubit, AddressesState>(
                          listener: (context, state) {
                            if (state is AddAddressesErrorState) {
                              AppSnackBar.showError(state.error);
                            }
                            if (state is AddAddressesSuccessState) {
                              AddressesCubit.get(context).getAddresses();
                              AppToast.showToastSuccess(state.message);
                              Navigator.of(context).pop();
                            }
                          },
                          builder: (context, state) {
                            return AppButton(
                                loading: state is AddAddressesLoadingState,
                                onPressed: () {
                                  if (_form.currentState!.validate()) {
                                    AddressesCubit.get(context).addAddresses({
                                      "address": address.text,
                                      "country_id": CountriesCubit.get(context).countriesModel!.id,
                                      "state_id": StateCubit.get(context).statesModel!.id,
                                      "city_id": CityCubit.get(context).citiesModel!.id,
                                      "latitude": latLng!.latitude,
                                      "longitude": latLng!.longitude,
                                      "title": name.text,
                                      "phone": phone.text,
                                      "is_primary": isDefault,
                                    });
                                  }
                                },
                                title: context.tr.save);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * .025,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  //       value: item,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             item,
  //             style: const TextStyle(
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  ///dropdown
  DropdownMenuItem<Country> buildMenuItemCountriesModel(Country item) => DropdownMenuItem(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  DropdownMenuItem<StateEntity> buildMenuItemStatesModel(StateEntity item) => DropdownMenuItem(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  DropdownMenuItem<City> buildMenuItemCities(City item) => DropdownMenuItem(
        value: item,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
}

class HeightSpace extends StatelessWidget {
  const HeightSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .02,
    );
  }
}
