import 'package:flutter/material.dart';

import '../../../../resources/colors/colors.dart';
import '../../data/models/transaction.dart';

class WalletWidget extends StatelessWidget {
  final TransactionModel transaction;
  const WalletWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.gray,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  if (transaction.type == "pay_in")
                    const Icon(
                      Icons.arrow_circle_down,
                      color: AppColors.primaryL,
                    ),
                  if (transaction.type == "pay_out")
                    const Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.red,
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    transaction.createdAt,
                    style: const TextStyle(
                      color: AppColors.gray,
                    ),
                  ),
                ]),
                Text(
                  transaction.amount,
                  style: const TextStyle(
                    color: AppColors.primaryL,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            if (transaction.reason.isNotEmpty)
              Text(
                transaction.reason,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(color: AppColors.black),
              ),
          ],
        ),
      ),
    );
  }
}
