import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final Function onPressedYes;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.onPressedYes,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              // IconButton(
              //   onPressed: () => Navigator.of(context).pop(),
              //   icon: Icon(AppIcons.close),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, color: AppColors.secondaryL),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Center(
                  child: Container(
                    height: 1.0,
                    color: AppColors.gray,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onPressedYes();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.yes,
                      style: const TextStyle(color: AppColors.primaryL),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Container(
                        width: 1.0,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.no,
                      style: const TextStyle(color: AppColors.primaryL),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
