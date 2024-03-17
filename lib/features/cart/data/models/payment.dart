class PaymentModel {
  PaymentModel({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
  });
  late final int id;
  late final String name;
  late final String type;
  late final int isActive;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_active'] = isActive;
    return data;
  }
}
