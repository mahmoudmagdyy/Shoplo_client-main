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
import '../../../network/presentation/pages/network_sensitive.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/state.dart';
import '../cubit/city/city_cubit.dart';
import '../cubit/country/country_cubit.dart';
import '../cubit/state/state_cubit.dart';
import '../widgets/switch_button.dart';

class EditAddress extends StatefulWidget {
  final int id;

  const EditAddress({Key? key, required this.id}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
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

  ///dropdown
  int? countriesId;
  int? stateId;
  int? cityId;

  bool initStates = true;
  bool initCities = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CountriesCubit.get(context).resetCubit();
    StateCubit.get(context).resetCubit();
    CityCubit.get(context).resetCubit();
    AddressesCubit.get(context).getAddressDetails(widget.id);
    CountriesCubit.get(context).getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appAppBar(context, context.tr.edit_address),
      body: NetworkSensitive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                BlocConsumer<AddressesCubit, AddressesState>(
                  listener: (context, state) {
                    if (state is GetAddressesDetailsSuccessState) {
                      ///drobdown
                      countriesId = state.addresses.city.state.country.id;
                      //StateCubit.get(context).getStates(countriesId);
                      stateId = state.addresses.city.state.id;
                      //CityCubit.get(context).getCites(stateId);

                      ///TextField
                      cityId = state.addresses.city.id;
                      name.text = state.addresses.title;
                      address.text = state.addresses.address;
                      latLng = LatLng(double.parse(state.addresses.latitude), double.parse(state.addresses.longitude));

                      ///phone
                      phone.text = state.addresses.phone;
                      countryCode = state.addresses.city.state.country.phoneCode;

                      isDefault = state.addresses.isPrimary;

                      ///LatLng
                      try {
                        latLng = LatLng(double.parse(state.addresses.latitude), double.parse(state.addresses.longitude));
                      } catch (e) {
                        latLng = null;
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAddressesDetailsLoadingState) {
                      return const AppLoading();
                    } else {
                      return Form(
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
                              //   baseCountryCode: countryCode,
                              //   onSelect: (val) {
                              //     countryCode = val;
                              //   },
                              // ),
                              // const HeightSpace(),
                              // AppTextFormField(controller: email, label: context.tr.email),

                              const HeightSpace(),
                              BlocConsumer<CountriesCubit, CountriesState>(
                                listener: (context, state) {
                                  if (state is CountriesSuccessStateNew) {
                                    CountriesCubit.get(context).setCountriesModel(countriesId!);
                                    StateCubit.get(context).resetCubit();
                                    CityCubit.get(context).resetCubit();
                                    StateCubit.get(context).getStates(countriesId);
                                  }
                                },
                                builder: (context, state) {
                                  return DropdownButtonFormField<Country>(
                                    key: _dropdownStateCountries,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    items: CountriesCubit.get(context).countries.map(buildMenuItemCountriesModel).toList(),
                                    // value: (CountriesCubit.get(context).countries.isNotEmpty)
                                    //     ? CountriesCubit.get(context).countries[getIndex(CountriesCubit.get(context).countries, countriesId!)]
                                    //     : null,
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
                                      countriesId = newVal.id;
                                      StateCubit.get(context).resetCubit();
                                      CityCubit.get(context).resetCubit();
                                      StateCubit.get(context).getStates(countriesId);
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
                              BlocConsumer<StateCubit, StateState>(
                                listener: (context, state) {
                                  if (state is StatesSuccessStateNew && initStates) {
                                    StateCubit.get(context).setStateModel(stateId!);
                                    CityCubit.get(context).resetCubit();
                                    CityCubit.get(context).getCites(stateId);
                                    setState(() {
                                      initStates = false;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  return DropdownButtonFormField<StateEntity>(
                                    key: _dropdownStateStates,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    items: StateCubit.get(context).states.map(buildMenuItemStatesModel).toList(),
                                    // value: (StateCubit.get(context).states.isNotEmpty)
                                    //     ? StateCubit.get(context).states[getIndex(StateCubit.get(context).states, stateId!)]
                                    //     : null,
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
                                      stateId = newVal.id;
                                      CityCubit.get(context).resetCubit();
                                      CityCubit.get(context).getCites(stateId);
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
                              BlocConsumer<CityCubit, CityState>(
                                listener: (context, state) {
                                  if (state is CitiesSuccessStateNew && initCities) {
                                    CityCubit.get(context).setCityModel(cityId!);
                                    setState(() {
                                      initCities = false;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  return DropdownButtonFormField<City>(
                                    key: _dropdownStateCities,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    items: CityCubit.get(context).cites.map(buildMenuItemCities).toList(),
                                    // value: (CityCubit.get(context).cites.isNotEmpty)
                                    //     ? CityCubit.get(context).cites[getIndex(CityCubit.get(context).cites, cityId!)]
                                    //     : null,
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
                                      cityId = newVal!.id;
                                      CityCubit.get(context).setSelectedCitesModel(newVal);
                                      latLng = LatLng(newVal.latitude.toDouble, newVal.longitude.toDouble);
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
                              LocationTextFormField(
                                controller: address,
                                latLng: latLng,
                                label: context.tr.address,
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
                                  val: isDefault,
                                  onVal: (val) {
                                    setState(() {
                                      isDefault = val;
                                    });
                                  }),
                              BlocConsumer<AddressesCubit, AddressesState>(
                                listener: (context, state) {
                                  if (state is EditAddressesErrorState) {
                                    AppSnackBar.showError(state.error);
                                  }
                                  if (state is EditAddressesSuccessState) {
                                    AddressesCubit.get(context).getAddresses();
                                    AppToast.showToastSuccess(context.tr.edited_success);
                                    Navigator.of(context).pop(state.address);
                                  }
                                },
                                builder: (context, state) {
                                  return AppButton(
                                      loading: state is EditAddressesLoadingState,
                                      onPressed: () {
                                        if (_form.currentState!.validate()) {
                                          AddressesCubit.get(context).editAddresses({
                                            "address": address.text,
                                            "country_id": CountriesCubit.get(context).countriesModel != null
                                                ? CountriesCubit.get(context).countriesModel!.id
                                                : countriesId,
                                            "state_id":
                                                StateCubit.get(context).statesModel != null ? StateCubit.get(context).statesModel!.id : stateId,
                                            "city_id": CityCubit.get(context).citiesModel != null ? CityCubit.get(context).citiesModel!.id : cityId,
                                            "latitude": latLng!.latitude.toString(),
                                            "longitude": latLng!.longitude.toString(),
                                            "title": name.text,
                                            "phone": phone.text,
                                            "is_primary": isDefault,
                                          }, widget.id);
                                        }
                                      },
                                      title: context.tr.save);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
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
