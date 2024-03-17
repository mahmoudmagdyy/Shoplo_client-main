import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';

import '../../core/config/constants.dart';
import '../../features/addresses/domain/entities/country.dart';
import '../../features/auth/presentation/cubit/country/country_cubit.dart';
import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';
import '../app_loading.dart';
import '../app_snack_bar.dart';
import '../header_decoration.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool edit;
  final bool readOnly;
  final bool enable;
  final Function()? onPress;
  final ValueChanged<String>? onSelect;
  final String baseCountryCode;
  final String ?label;

  const PhoneTextFormField({
    Key? key,
    required this.controller,
    this.edit = false,
    this.onPress,
    this.readOnly = false,
    this.onSelect,
    this.baseCountryCode = "",
    this.enable = true,  this.label="",
  }) : super(key: key);

  @override
  State<PhoneTextFormField> createState() => _PhoneTextFormFieldState();
}

class _PhoneTextFormFieldState extends State<PhoneTextFormField> {
  ///countries
  String countryCode = '';
  String flag = '';
  late List<Country> countries = [];

  showCountryPicker(BuildContext context) {
    if (countries.isEmpty) {
      AppSnackBar.showError(context.tr.there_is_no_countries);
      return;
    }
    var countriesData = countries
        .map((e) => PickerItem(
            text: Text(
              e.name,
              style: AppTextStyle.textStyleRegularAppBlack18,
            ),
            value: e.phoneCode))
        .toList();
    final selectedIndex =
        countries.indexWhere((e) => e.phoneCode == countryCode);
    debugPrint('SELECTED: $selectedIndex}', wrapWidth: 1024);

    Picker(
      height: 200,
      diameterRatio: 8,
      itemExtent: 40,
      containerColor: AppColors.black,
      looping: false,
      smooth: 5,
      textScaleFactor: 5,
      hideHeader: true,
      magnification: 1.2,
      backgroundColor: Colors.white,

      selectedTextStyle: AppTextStyle.textStyleWhiteMedium,
      onSelect:(picker, index, selected) {
        var selectedCountry = countries.firstWhere(
                (element) => element.phoneCode == picker.getSelectedValues()[0]);
        setState(() {
          countryCode = selectedCountry.phoneCode;
          flag = selectedCountry.flag;
          widget.onSelect!(countryCode);
        });
      },
      headerColor: AppColors.primaryL,
      headerDecoration: headerDecoration(),
      selecteds: selectedIndex != -1 ? [selectedIndex] : [],
      adapter: PickerDataAdapter(data: countriesData),
      title: Text(context.tr.country,style: AppTextStyle.textStyleMediumPrimary,),
      cancelText: context.tr.cancel,

      cancelTextStyle: const TextStyle(
        color: AppColors.primaryL,
      ),
      confirmText: context.tr.confirm,
      confirmTextStyle: const TextStyle(color: AppColors.primaryL),
      onConfirm: (Picker picker, List value) {
        var selectedCountry = countries.firstWhere(
            (element) => element.phoneCode == picker.getSelectedValues()[0]);
        setState(() {
          countryCode = selectedCountry.phoneCode;
          flag = selectedCountry.flag;
          widget.onSelect!(countryCode);
        });
      },
    ).showDialog(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.baseCountryCode!=""){
    //   countryCode =widget.baseCountryCode;
    // }
    context.read<CountryCubit>().getCountries(all: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              widget.label.toString(),
              style: AppTextStyle.textStyleMediumGray2
          ),
          widget.label.toString()!=""? SizedBox(height: 10,): SizedBox(height: 0,),
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              enabled: widget.enable,
              readOnly: widget.readOnly,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                //To remove first '0'
                FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              ],
              textInputAction: TextInputAction.next,
              controller: widget.controller,
              cursorColor: AppColors.primaryL,
              style: AppTextStyle.textStyleEditTextValueRegularBlack,
              decoration: InputDecoration(
                hintText: context.tr.mobile_num,
                suffixIcon: widget.edit
                    ? IconButton(
                        icon: SvgPicture.asset(AppImages.svgEdit),
                        onPressed: widget.onPress,
                      )
                    : null,
                prefixIcon: SizedBox(
                  width: context.width * 0.3,

                  child: BlocConsumer<CountryCubit, CountryState>(
                    listener: (context, state) {
                      if (state is GetCountriesLoadedState && countryCode == '') {
                        countries = state.data as List<Country>;
                        if (widget.baseCountryCode != "") {
                          countryCode = widget.baseCountryCode;
                        } else {
                          countryCode = countries[0].phoneCode;
                        }
                        widget.onSelect!(countryCode);
                        // countryId = countries[0]['id'].toString();
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.padding10,
                          vertical: Constants.padding5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.borderGrey2,
                            borderRadius: BorderRadius.circular(Constants.padding15),
                          ),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(context);
                            },
                            child: SizedBox(
                              width: context.width * .17,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  state is GetCountriesLoadingState
                                      ? const AppLoading(
                                          scale: .5,
                                          color: AppColors.primaryL,
                                        )
                                      : Text(
                                          countryCode,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle
                                              .textStyleEditTextLabelRegularBlack,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Constants.padding5),
                                    child: SvgPicture.asset(AppImages.down),
                                  ),
                                  // Container(
                                  //   height: context.height * .03,
                                  //   width: 2,
                                  //   color: AppColors.grey.withOpacity(.5),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      // if (state is GetCountriesLoadingState) {
                      //   return  AppLoading(
                      //     scale: .5,
                      //     color: AppColors.primaryL,
                      //   );
                      // } else if (state is GetCountriesLoadedState) {
                      //   return GestureDetector(
                      //     onTap: () {
                      //       showCountryPicker(context);
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text("966" /*"countryCode"*/,
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(color: AppColors.black.withOpacity(.7)),
                      //         ),
                      //         const Icon(Icons.arrow_drop_down),
                      //         const SizedBox(width: 5),
                      //         // Container(
                      //         //   height: height * .03,
                      //         //   width: 2,
                      //         //   color: AppColors.grey
                      //         //       .withOpacity(.5),
                      //         // ),
                      //         Column( // Dashed line
                      //           children: [
                      //             for (int i = 0; i < 12; i++)
                      //               Container(
                      //                 width: 1,
                      //                 height: 2,
                      //                 decoration: BoxDecoration(
                      //                   border: Border(
                      //                     bottom: BorderSide(
                      //                       width: 2,
                      //                       color: i % 2 == 0
                      //                           ? const Color
                      //                           .fromRGBO(
                      //                           214, 211, 211, 1)
                      //                           : AppColors
                      //                           .textGray,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //           ],
                      //         ),
                      //         const SizedBox(width: 15),
                      //       ],
                      //     ),
                      //   );
                      // } else {
                      //   return Container();
                      // }
                    },
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return context.tr.required;
                } else if (!value.isValidMinLength(7)) {
                  return context.tr.at_least_7_num;
                } else if (!value.isValidMaxLength(15)) {
                  return context.tr.at_most_15_num;
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
