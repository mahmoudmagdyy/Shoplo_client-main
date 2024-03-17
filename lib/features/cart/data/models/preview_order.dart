class PreviewOrderModal {
  PreviewOrderModal({
    required this.subtotal,
    required this.offerDiscount,
    required this.deliveryCharge,
    required this.promoCodeDiscount,
    required this.promoCodeType,
    required this.total,
    required this.addedTax,
    required this.wallet,
    required this.walletPayout,
    required this.remain,
  });
  late final String subtotal;
  late final String offerDiscount;
  late final String deliveryCharge;
  late final String promoCodeDiscount;
  late final String promoCodeType;
  late final String total;
  late final String addedTax;
  late final String wallet;
  late final String walletPayout;
  late final String remain;

  PreviewOrderModal.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    offerDiscount = json['offer_discount'];
    deliveryCharge = json['delivery_charge'];
    promoCodeDiscount = json['promo_code_discount'];
    promoCodeType = json['promo_code_type'];
    total = json['total'];
    addedTax = json['added_tax'];
    wallet = json['wallet'];
    walletPayout = json['wallet_payout'];
    remain = json['remain'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['offer_discount'] = offerDiscount;
    data['delivery_charge'] = deliveryCharge;
    data['promo_code_discount'] = promoCodeDiscount;
    data['promo_code_type'] = promoCodeType;
    data['total'] = total;
    data['added_tax'] = addedTax;
    data['wallet'] = wallet;
    data['wallet_payout'] = walletPayout;
    data['remain'] = remain;
    return data;
  }
}
