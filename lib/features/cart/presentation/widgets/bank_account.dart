import 'package:flutter/material.dart';
import 'package:shoplo_client/widgets/index.dart';

import '../../data/models/bank_account.dart';

class BankAccountWidget extends StatelessWidget {
  final BankAccountModel bankAccount;
  final BankAccountModel selectedBankAccount;
  final Function(BankAccountModel bankAccount) onSelected;

  const BankAccountWidget({
    super.key,
    required this.bankAccount,
    required this.selectedBankAccount,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      // contentPadding:EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bankAccount.name),
              Text(bankAccount.ibanNumber),
            ],
          ),
          AppImage(
            imageURL: bankAccount.image,
            width: 60,
            height: 50,
            fit: BoxFit.cover,
            borderRadius: 10,
          )
        ],
      ),
      value: bankAccount,
      groupValue: selectedBankAccount,
      onChanged: (value) {
        onSelected(value!);
      },
    );
  }
}
