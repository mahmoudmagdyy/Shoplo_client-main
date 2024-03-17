import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/config/constants.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/shoplo/language_sheet.dart';

class IntroLanguage extends StatefulWidget {
  const IntroLanguage({Key? key}) : super(key: key);

  @override
  State<IntroLanguage> createState() => _IntroLanguageState();
}

class _IntroLanguageState extends State<IntroLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors.primaryL,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryL,
      ),
      body: Container(
        height: context.height,
        width: context.width,
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(Constants.padding10),
                      // child: Image.asset(AppImages.deliveryDrop),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Image.asset(AppImages.logoWithName),
                ),
                const Expanded(
                  flex: 8,
                  child: LanguageSheet(isIntro: true),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
