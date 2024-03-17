import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoplo_client/core/config/constants.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final String iconName;
  final IconData? iconIcon;
  final String routeName;
  final bool line;
  final Function()? onTap;
  const DrawerItem({
    super.key,
    required this.title,
    required this.iconName,
    required this.routeName,
    this.line = true,
    this.onTap,
    this.iconIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding5),
      child: Column(
        children: [
          ListTile(
            onTap: onTap ??
                () {
                  Navigator.pushNamed(context, routeName);
                },
            leading: iconIcon != null
                ? Icon(
                    iconIcon,
                    color: AppColors.white,
                  )
                : SvgPicture.asset(
                    iconName,
                    width: iconName == AppImages.logo ? 30 : 25,
                  ),
            title: Text(
              title,
              style: AppTextStyle.textStyleWhiteMedium,
            ),
          ),
          if (line)
            Container(
              height: 0.5,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              color: AppColors.white,
            ),
        ],
      ),
    );
  }
}
