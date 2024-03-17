import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/services/navigation_service.dart';
import '../resources/colors/colors.dart';

class AppToast {
  AppToast._();

  static void showToastSuccess(String message, {BuildContext? context}) =>
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryL,
          textColor: Colors.white,
          fontSize: 16.0
      );


  static void showToastError(String message, {BuildContext? context}) =>
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
}
