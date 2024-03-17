class BankAccountModel {
  BankAccountModel({
    required this.id,
    required this.isActive,
    required this.image,
    required this.accountNumber,
    required this.ibanNumber,
    required this.name,
    required this.createdAt,
  });
  late final int id;
  late final bool isActive;
  late final String image;
  late final String accountNumber;
  late final String ibanNumber;
  late final String name;
  late final String createdAt;

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    image = json['image'];
    accountNumber = json['account_number'];
    ibanNumber = json['iban_number'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['image'] = image;
    data['account_number'] = accountNumber;
    data['iban_number'] = ibanNumber;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
