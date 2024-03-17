import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../core/config/constants.dart';
import '../../core/routes/app_routes.dart';
import '../../features/home/presentation/cubit/location_cubit.dart';
import '../../resources/colors/colors.dart';
import '../../resources/styles/app_text_style.dart';

class LocationTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool edit;
  final bool readOnly;
  final bool enable;
  final int? maxLine;
  final LatLng? latLng;
  final Function()? onPress;
  final Widget? suffixIcon;
  final ValueChanged<LatLng>? onDetectLocation;
  const LocationTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.edit = false,
    this.readOnly = false,
    this.onPress,
    this.maxLine,
    this.suffixIcon,
    this.enable = true,
    this.latLng,
    this.onDetectLocation,
  }) : super(key: key);

  @override
  State<LocationTextFormField> createState() => _LocationTextFormFieldState();
}

class _LocationTextFormFieldState extends State<LocationTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        style: AppTextStyle.textStyleEditTextValueRegularBlack,
        decoration: InputDecoration(
            labelText: widget.label,
            suffixIcon: SizedBox(
              width: 20,
              child: BlocProvider(
                create: (context) => LocationCubit(),
                child: BlocBuilder<LocationCubit, LocationState>(
                    builder: (context, state) {
                  //  if (state is GetCurrentLocationSuccessState) {
                  // final LatLng latLng1 = state.latLng;
                  debugPrint('LAT LNG : ${widget.latLng}', wrapWidth: 1024);
                  // widget.onDetectLocation!(latLng1);
                  return InkWell(
                    onTap: () async {
                      final result = await Navigator.of(context)
                          .pushNamed(AppRoutes.mapSearchScreen, arguments: {
                        "LatLng": widget.latLng,
                      });
                      if (result != null) {
                        log("result $result");
                        Map<String, dynamic> result1 =
                            result as Map<String, dynamic>;
                        if (result1.isNotEmpty) {
                          debugPrint("callback location address $result1");
                          setState(() {
                            widget.controller.text = result1["text"];
                            final latLngNew =
                                LatLng(result1["lat"], result1["lng"]);
                            widget.onDetectLocation!(latLngNew);
                          });
                        }
                      }

                      //     .then((value) {

                      //   Map<String, dynamic> result =
                      //       value as Map<String, dynamic>;
                      //   setState(() {
                      //     widget.controller.text = result["text"];
                      //     latLng = LatLng(result["lat"], result["lng"]);
                      //     widget.onDetectLocation!(latLng1);
                      //   });
                      // });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryL,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.white,
                          )),
                    ),
                  );
                }
                    // },
                    ),
              ),
            )),
        onEditingComplete: () => TextInput.finishAutofillContext(),
        onFieldSubmitted: (_) {
          // if (state is LoginLoadingState) return;
          // _saveForm(cubit, context);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return context.tr.required;
          }
          return null;
          // } else if (!value.isValidPassword) {
          //   return context.tr.password_validations;
          // } else if (!value.isValidMinLength(8)) {
          //   return context.tr.at_least_7_char;
          // } else if (!value.isValidMaxLength(15)) {
          //   return context.tr.at_most_15_char;
          // } else {
          //   return null;
          // }
        },
        onSaved: (value) {},
      ),
    );
  }
}
