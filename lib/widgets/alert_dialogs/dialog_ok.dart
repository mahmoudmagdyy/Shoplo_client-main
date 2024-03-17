import 'package:flutter/material.dart';
import '../../core/config/constants.dart';
import '../../resources/colors/colors.dart';

class CustomDialogBoxOk extends StatefulWidget {
  final String title;
  final String? message;

  final Function onPressedYes;

  const CustomDialogBoxOk({
    Key? key,
    required this.title,
    this.message,
    required this.onPressedYes,
  }) : super(key: key);

  @override
  _CustomDialogBoxOkState createState() => _CustomDialogBoxOkState();
}

class _CustomDialogBoxOkState extends State<CustomDialogBoxOk> {
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
                    fontSize: 20,
                    color: AppColors.primaryL,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              if (widget.message != null)
                Text(
                  widget.message!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
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
              TextButton(
                onPressed: () {
                  widget.onPressedYes();
                },
                child: Text(
                   context.tr.ok,
                  style: const TextStyle(
                    color: AppColors.primaryL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
