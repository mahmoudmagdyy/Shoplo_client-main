class MultipleOrderTotal {
  String subtotal = "0.00";
  String offerDiscount = "0.00";
  String deliveryCharge = "0.00";
  String promoCodeDiscount = "0.00";
  String promoCodeType = "";
  String total = "0.00";
  String addedTax = "0.00";
  String wallet = "0.00";
  String walletPayout = "0.00";
  String remain = "0.00";

  MultipleOrderTotal(
      {required this.subtotal,
      required this.offerDiscount,
      required this.deliveryCharge,
      required this.promoCodeDiscount,
      required this.promoCodeType,
      required this.total,
      required this.addedTax,
      required this.wallet,
      required this.walletPayout,
      required this.remain});

  factory MultipleOrderTotal.fromJson(Map<String, dynamic> json) {
    return MultipleOrderTotal(
      subtotal: json['subtotal'] ?? "0.00",
      offerDiscount: json['offer_discount'] ?? "0.00",
      deliveryCharge: json['delivery_charge'] ?? "0.00",
      promoCodeDiscount: json['promo_code_discount'] ?? "0.00",
      promoCodeType: json['promo_code_type'] ?? "",
      total: json['total'] ?? "0.00",
      addedTax: json['added_tax'] ?? "0.00",
      wallet: json['wallet'] ?? "0.00",
      walletPayout: json['wallet_payout'] ?? "0.00",
      remain: json['remain'] ?? "0.00",
    );
  }
}
