class Country {
  Country({
     required this.id,
     required this.name,
     required this.code,
     required this.phoneCode,
     required this.flag,
     required this.isActive,
     required this.createdAt,
  });

  final int id;
  final String name;
  final String code;
  final String phoneCode;
  final String flag;
  final bool isActive;
  final String createdAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"]??0,
    name: json["name"]??"",
    code: json["code"]??"",
    phoneCode: json["phone_code"]??"",
    flag: json["flag"]??"",
    isActive: json["is_active"]??true,
    createdAt: json["created_at"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "phone_code": phoneCode,
    "flag": flag,
    "is_active": isActive,
    "created_at": createdAt,
  };
}