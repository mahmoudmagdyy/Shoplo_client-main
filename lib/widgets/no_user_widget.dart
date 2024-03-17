import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../core/routes/app_routes.dart';
import '../resources/colors/colors.dart';
import 'app_button.dart';
import 'app_button_outline.dart';

class NoUserWidget extends StatelessWidget {
  final bool isAlertDialog;
  const NoUserWidget({
    Key? key,
    this.isAlertDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isAlertDialog ? Colors.transparent : AppColors.backgroundLightGray,
      width: double.infinity,
      height: !isAlertDialog ? double.infinity : 350,
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // if (isAlertDialog)
            //   Row(
            //     children: [
            //       IconButton(
            //         onPressed: () => Navigator.of(context).pop(),
            //         icon: const Icon(
            //           Icons.close,
            //           color: AppColors.primaryL,
            //         ),
            //       ),
            //     ],
            //   ),
            Text(
              context.tr.welcome_again,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryL,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text.rich(
              TextSpan(
                text: context.tr.you_logged_as,
                style: const TextStyle(
                  fontSize: 16,
                ), // default text style
                children: <TextSpan>[
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: context.tr.guest,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryL,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              context.tr.please_login,
              style: const TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              // width: 200,
              // height: 30,
              title: context.tr.login,
              onPressed: () {
                if (isAlertDialog) Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.login);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            AppButtonOutline(
              title: context.tr.create_new_account,
              onPressed: () {
                if (isAlertDialog) Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(AppRoutes.userTypeScreen);
                Navigator.of(context).pushNamed(AppRoutes.register);},
            ),
          ],
        ),
      ),
    );
  }
}
