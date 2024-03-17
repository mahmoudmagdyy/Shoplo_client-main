import 'package:shoplo_client/features/addresses/data/models/address_model.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.gender,
    required this.avatar,
    required this.wallet,
    required this.type,
    required this.isActive,
    required this.lastLoginAt,
    required this.addresses,
    required this.verificationCode,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String countryCode;
  final String phone;
  final String email;
  final dynamic gender;
  final String avatar;
  final String type;
  final String wallet;
  final bool isActive;
  final String lastLoginAt;
  final List<AddressModel> addresses;
  final String verificationCode;
  final String createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      countryCode: json["country_code"],
      phone: json["phone"],
      email: json["email"],
      wallet: json["wallet"]?.toString() ?? "",
      gender: json["gender"],
      avatar: json["avatar"],
      type: json["type"],
      isActive: json["is_active"],
      lastLoginAt: json["last_login_at"] ?? "",
      addresses: json["addresses"] != null ? List<AddressModel>.from(json["addresses"].map((x) => AddressModel.fromJson(x))) : [],
      verificationCode: json["verification_code"] ?? "",
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "phone": phone,
        "email": email,
        "gender": gender,
        "avatar": avatar,
        "type": type,
        "is_active": isActive,
        "last_login_at": lastLoginAt,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "verification_code": verificationCode,
        "created_at": createdAt,
      };
}
