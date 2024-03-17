import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../core/config/constants.dart';
import '../../features/chat/presentation/cubit/uploader_cubit/uploader_cubit.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';
import '../app_toast.dart';

class AppImageFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool edit;
  final bool readOnly;
  final bool enable;
  final int? maxLine;
  final TextInputType keyboardType;
  final void Function()? onPress;
  final void Function()? onTap;
  final Widget? suffixIcon;

  const AppImageFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.edit = false,
    this.readOnly = false,
    this.onPress,
    this.onTap,
    this.maxLine,
    this.suffixIcon,
    this.enable = true,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<AppImageFormField> createState() => _AppImageFormFieldState();
}

class _AppImageFormFieldState extends State<AppImageFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: BlocConsumer<UploaderCubit, UploaderState>(
        listener: (context, state) {
          if (state is UploadErrorState) {
            AppToast.showToastError(state.error);
          }
          if (state is UploadSuccessState) {
            // imageUri.value = state.data['file'];
          }
        },
        builder: (context, state) {
          return TextFormField(
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            maxLines: widget.maxLine,
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keyboardType,
            style: AppTextStyle.textStyleEditTextValueRegularBlack,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: widget.suffixIcon ??
                  (widget.edit
                      ? IconButton(
                          icon: SvgPicture.asset(AppImages.svgEdit),
                          onPressed: widget.onPress,
                        )
                      : null),
            ),
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
          );
        },
      ),
    );
  }
}
