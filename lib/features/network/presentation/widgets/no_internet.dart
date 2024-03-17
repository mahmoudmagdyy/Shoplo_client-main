import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

import '../../../../resources/colors/colors.dart';

class NoInterNetConnection extends StatelessWidget {
  const NoInterNetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 30),
            // Image.asset(
            //   AppImages.noResult,
            //   height: 200,
            //   width: 200,
            //   fit: BoxFit.cover,
            // ),
            const Icon(
              Icons.wifi_off,
              size: 50,
              color: AppColors.black,
            ),
            const SizedBox(height: 30),
            Text(
              context.tr.sorry_no_internet,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 50),
            // AppButton(
            //   width: 280,
            //   title:  context.tr.back,
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
