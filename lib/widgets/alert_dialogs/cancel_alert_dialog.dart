import 'package:flutter/material.dart';

import '../../core/config/constants.dart';
import '../../core/extensions/extensions_on_string.dart';
import '../../resources/colors/colors.dart';
import '../app_button.dart';

class CancelDialogBox extends StatefulWidget {
  final int id;
  final String title;
  final Function onPressedYes;

  const CancelDialogBox({
    Key? key,
    required this.title,
    required this.onPressedYes,
    required this.id,
  }) : super(key: key);

  @override
  _CancelDialogBoxState createState() => _CancelDialogBoxState();
}

class _CancelDialogBoxState extends State<CancelDialogBox> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(color: Colors.black,offset: Offset(0,5),
            //   blurRadius: 10
            //   ),
            // ]
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // IconButton(
                //   onPressed: () => Navigator.of(context).pop(),
                //   icon: const Icon(Icons.close),
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.title,
                    style:
                        const TextStyle(fontSize: 20, color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  controller: reason,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    labelText: context.tr.reason_for_rejection,
                  ),
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColors.primaryL,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return context.tr.required;
                    } else if (!value.isValidMinLength(4)) {
                      return context.tr.at_least_4_char;
                    } else if (!value.isValidMaxLength(75)) {
                      return context.tr.at_most_75_char;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  title: context.tr.save,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onPressedYes(reason.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
