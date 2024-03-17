import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';
import 'package:shoplo_client/core/extensions/extensions_on_string.dart';

import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool edit;
  final bool readOnly;
  final bool enabled;
  final String? title;
  final Function()? onPress;
  final bool isTrue;
  const PasswordTextFormField({
    Key? key,
    required this.controller,
    required this.label,

    this.edit = false,
    this.onPress,
    this.readOnly = false, this.enabled=true, this.title="",  this.isTrue= true,
  }) : super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  ///password
  bool _obscureText = true;
  final _passwordFocusNode = FocusNode();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
            enabled: widget.enabled,
              readOnly: widget.readOnly,
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              style: AppTextStyle.textStyleEditTextValueRegularBlack,
              decoration: InputDecoration(
                hintText: widget.label,
                // hintText:widget.label ,
                suffixIcon: IconButton(
                  icon: widget.edit
                      ? SvgPicture.asset(AppImages.svgEdit)
                      : Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.borderGrey2,
                        ),
                  onPressed: widget.edit ? widget.onPress : _toggle,
                ),
                prefixIcon:widget.isTrue ?IconButton(
                  icon:SvgPicture.asset(AppImages.lock,color:AppColors.black),
                  onPressed: () {},

                ):Container(width: 0,),
                floatingLabelBehavior:widget.readOnly?FloatingLabelBehavior.never: null,
              ),
              autofillHints: const [AutofillHints.password],
              onEditingComplete: () => TextInput.finishAutofillContext(),
              cursorColor: AppColors.primaryL,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (_) {
                // if (state is LoginLoadingState) return;
                // _saveForm(cubit, context);
              },

              validator: (value) {
                if (value!.isEmpty) {
                  return context.tr.required;
                } else if (!value.isValidPassword) {
                  return context.tr.password_validations;
                } else if (!value.isValidMinLength(8)) {
                  return context.tr.at_least_7_char;
                } else if (!value.isValidMaxLength(15)) {
                  return context.tr.at_most_15_char;
                } else {
                  return null;
                }
              },
              onSaved: (value) {}),
        ],
      ),
    );
  }
}
