class TransactionModel {
  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.reason,
    required this.transactableType,
    required this.transactableId,
    required this.createdAt,
    required this.user,
  });
  late final int id;
  late final String type;
  late final String amount;
  late final String reason;
  late final String transactableType;
  late final int transactableId;
  late final String createdAt;
  late final User user;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    reason = json['reason'] ?? '';
    transactableType = json['transactable_type'];
    transactableId = json['transactable_id'];
    createdAt = json['created_at'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['amount'] = amount;
    data['reason'] = reason;
    data['transactable_type'] = transactableType;
    data['transactable_id'] = transactableId;
    data['created_at'] = createdAt;
    data['user'] = user.toJson();
    return data;
  }
}

class Ar {
  Ar({
    required this.reason,
  });
  late final String reason;

  Ar.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reason'] = reason;
    return data;
  }
}

class En {
  En({
    required this.reason,
  });
  late final String reason;

  En.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reason'] = reason;
    return data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.type,
    required this.city,
    required this.isActive,
    required this.createdAt,
    required this.verificationCode,
  });
  late final int id;
  late final String name;
  late final String countryCode;
  late final String phone;
  late final String email;
  late final String avatar;
  late final String type;
  late final String city;
  late final bool isActive;
  late final String createdAt;
  late final String verificationCode;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    type = json['type'];
    city = json['city'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['type'] = type;
    data['city'] = city;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['verification_code'] = verificationCode;
    return data;
  }
}
