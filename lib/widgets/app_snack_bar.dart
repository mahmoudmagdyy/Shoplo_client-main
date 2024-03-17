import 'package:flutter/material.dart';
import '../core/services/navigation_service.dart';
import '../resources/colors/colors.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showSuccess(String message, {BuildContext? context}) =>
      ScaffoldMessenger.of(
              context ?? NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.green,
        ),
      );

  static void showError(String message, {BuildContext? context}) =>
      ScaffoldMessenger.of(
              context ?? NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(
                  context ?? NavigationService.navigatorKey.currentContext!)
              .errorColor,
        ),
      );

  static void showInfo(String message, {BuildContext? context}) =>
      ScaffoldMessenger.of(
              context ?? NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            message,
            style: const TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.primaryL,
        ),
      );
}
