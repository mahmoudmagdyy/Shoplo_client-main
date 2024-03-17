import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/colors/colors.dart';

class AppLoading extends StatelessWidget {
  final Color color;
  final double scale;
  final double? value;
  const AppLoading({
    Key? key,
    this.color = AppColors.loadingColor,
    this.scale = 0.7,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: Platform.isIOS
            ? Theme(
                data: ThemeData(
                  cupertinoOverrideTheme: CupertinoThemeData(
                    brightness: color == Colors.white
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                ),
                child: const CupertinoActivityIndicator(
                  radius: 20,
                ),
              )
            : CircularProgressIndicator(
                color: color,
                value: value,
              ),
      ),
    );
  }
}
