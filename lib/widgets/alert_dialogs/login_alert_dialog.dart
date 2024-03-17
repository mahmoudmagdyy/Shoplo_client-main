import 'package:flutter/material.dart';
import '../../resources/colors/colors.dart';
import '../no_user_widget.dart';

class LoginAlertDialog extends StatefulWidget {
  const LoginAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  _LoginAlertDialogState createState() => _LoginAlertDialogState();
}

class _LoginAlertDialogState extends State<LoginAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: AppColors.primaryL,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(color: Colors.black,offset: Offset(0,5),
            //   blurRadius: 10
            //   ),
            // ]
          ),
          child: const NoUserWidget(
            isAlertDialog: true,
          ),
        ),
      ],
    );
  }
}
