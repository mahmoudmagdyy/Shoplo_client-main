import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/media/dimensions.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';

class SelectCategoryDialog extends HookWidget {
  final Function onPressedYes;

  const SelectCategoryDialog({
    Key? key,
    required this.onPressedYes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    var width = getSize(context).width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.select_category,
                  style: TextStyle(
                    // color: AppColors.primaryL,
                    fontSize: renderFontSizeFromPixels(
                      context,
                      k16TextSize,
                    ),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    onPressedYes('stores');
                  },
                  child: Stack(
                    alignment: Localizations.localeOf(context) ==
                            const Locale('ar', '')
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          AppImages.stores,
                          width: double.infinity,
                          height: width * .3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: Text(
                          AppLocalizations.of(context)!.stores,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    onPressedYes('restaurants');
                  },
                  child: Stack(
                    alignment: Localizations.localeOf(context) ==
                            const Locale('ar', '')
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          AppImages.restaurants,
                          width: double.infinity,
                          height: width * .3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: Text(
                          AppLocalizations.of(context)!.restaurants,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
