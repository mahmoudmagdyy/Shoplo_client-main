import 'package:flutter/material.dart';
import '../features/layout/presentation/cubit/app/app_cubit.dart';
import '../resources/colors/colors.dart';

class AppLinearGradient extends StatelessWidget {
  final Widget? child;
  const AppLinearGradient({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cubit.isRTL(context)
              ? [
                  AppColors.gradientHeader_2,
                  AppColors.gradientHeader_1,
                ]
              : [
                  AppColors.gradientHeader_1,
                  AppColors.gradientHeader_2,
                ],
        ),
      ),
      child: child,
    );
  }
}
