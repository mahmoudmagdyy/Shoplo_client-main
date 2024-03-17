import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../core/config/constants.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final bool edit;
  final bool readOnly;
  final bool enable;
  final int? maxLine;
  final TextInputType keyboardType;
  final void Function()? onPress;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final bool required;
  final String? Function(String?)? validator;
  final String? title;

  const AppTextFormField({
    Key? key,
    this.controller,
    required this.label,
    this.edit = false,
    this.required = true,
    this.readOnly = false,
    this.onPress,
    this.onTap,
    this.hint,
    this.maxLine,
    this.suffixIcon,
    this.enable = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.style,
    this.contentPadding,
    this.isDense,
    this.validator, this.title="",
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.toString()!=""?Text(
              widget.title.toString(),
              style: AppTextStyle.textStyleMediumGray2
          ):Container(height: 0,),
          widget.title.toString()!=""? SizedBox(height: 10,): SizedBox(height: 0,),
          TextFormField(
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            maxLines: widget.maxLine,
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keyboardType,
            style: widget.style ?? AppTextStyle.textStyleEditTextValueRegularBlack,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              isDense: widget.isDense,
              labelText: widget.label,
              suffixIcon: widget.suffixIcon ??
                  (widget.edit
                      ? IconButton(
                          icon: SvgPicture.asset(AppImages.svgEdit),
                          onPressed: widget.onPress,
                        )
                      : null),
            ),
            onChanged: widget.onChanged,
            validator: widget.required
                ? widget.validator ??
                    (value) {
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
                    }
                : null,
          ),
        ],
      ),
    );
  }
}
