import 'package:flutter/material.dart';
import 'package:shoplo_client/core/extensions/extensions_on_context.dart';

class CurrencyHelper {
  static String? currency;

  static String currencyString(BuildContext context, {String? nullableValue}) {
    return '${currency ?? nullableValue ?? context.tr.real} ';
  }
}
