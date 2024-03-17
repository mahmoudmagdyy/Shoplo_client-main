import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../resources/colors/colors.dart';
import '../../resources/images/images.dart';
import '../../resources/styles/app_text_style.dart';

AppBar appAppBar(
  BuildContext context,
  String title, {
  bool leading = true,
  List<Widget>? actions,
  Function()? onPress,
  Color? color,
}) {
  return AppBar(
    backgroundColor: color,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      // for Android
      statusBarIconBrightness: Brightness.dark,
      // for IOS
      statusBarBrightness: Brightness.light,
    ),
    title: Text(
      title,
      style: AppTextStyle.textStyleAppBar,
    ),
    elevation: 3,
    centerTitle: true,
    leading: leading
        ? InkWell(
            onTap: onPress ??
                () {
                  Navigator.pop(context);
                },
            child: Padding(
              padding: EdgeInsets.all(context.width * .045),
              child: SvgPicture.asset(
                AppImages.back,
                matchTextDirection: true,
              ),
            ),
          )
        : null,
    actions: actions,
  );
}
