import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/images/images.dart';
import '../../../../resources/styles/app_text_style.dart';
import '../../../../widgets/app_button.dart';

class IntroLogin extends StatefulWidget {
  const IntroLogin({Key? key}) : super(key: key);

  @override
  State<IntroLogin> createState() => _IntroLoginState();
}

class _IntroLoginState extends State<IntroLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryL,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryL,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryL,
          // for Android
          statusBarIconBrightness: Brightness.light,
          // for IOS
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        height: context.height,
        width: context.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.background,
            ),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryL, AppColors.secondaryL],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Center(child: Image.asset(AppImages.introLogin)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: context.width * .90,
                          child: Image.asset(
                            AppImages.login,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(context.width * .1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              context.tr.intro_title,
                              style: AppTextStyle.textStyleWhiteRegular33,
                            ),
                            Text(
                              context.tr.intro_desc,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.textStyleWhiteSemiBold,
                            ),
                          ],
                        ),
                        AppButton(
                            title: context.tr.next_btn,
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.login);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
