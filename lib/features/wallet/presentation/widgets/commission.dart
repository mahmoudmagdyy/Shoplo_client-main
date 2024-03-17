import 'package:flutter/material.dart';

import '../../../../core/helpers/currency_helper.dart';
import '../../../../resources/colors/colors.dart';
import '../../../../resources/styles/app_sized_box.dart';
import '../../../../resources/styles/app_text_style.dart';

class CommissionWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String price;
  final String routeName;
  const CommissionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.price,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryL,
              AppColors.secondaryL,
            ],
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: AppColors.textAppWhiteDark,
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.secondaryL,
                size: 25,
              ),
              // child: SvgPicture.asset(
              //   icon,
              //   width: 30,
              //   height: 30,
              // ),
            ),
            AppSizedBox.sizedW10,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.textStyleWhiteSemiBold19,
                  ),
                  Text(
                    '$price ${CurrencyHelper.currencyString(context)}',
                    style: AppTextStyle.textStyleWhiteSemiBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
