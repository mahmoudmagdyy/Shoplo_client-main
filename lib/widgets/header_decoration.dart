import 'package:flutter/material.dart';
import '../core/services/navigation_service.dart';
import '../features/layout/presentation/cubit/app/app_cubit.dart';
import '../resources/colors/colors.dart';

BoxDecoration headerDecoration() {
  AppCubit cubit = AppCubit.get(NavigationService.navigatorKey.currentContext!);
  return BoxDecoration(
    gradient: LinearGradient(
      colors: cubit.isRTL(NavigationService.navigatorKey.currentContext!)
          ? [
              AppColors.gradientHeader_2,
              AppColors.gradientHeader_1,
            ]
          : [
              AppColors.gradientHeader_1,
              AppColors.gradientHeader_2,
            ],
    ),
  );
}
