import 'package:flutter/material.dart';

import '../../data/models/payment.dart';

class PaymentMethodsWidget extends StatelessWidget {
  final PaymentModel paymentMethod;
  final PaymentModel selectedPaymentMethod;
  final Function(PaymentModel payment) onSelected;

  const PaymentMethodsWidget({
    super.key,
    required this.paymentMethod,
    required this.selectedPaymentMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      // contentPadding:EdgeInsets.zero,
      title: Text(paymentMethod.name),
      value: paymentMethod,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        onSelected(value!);
      },
    );
  }
}
