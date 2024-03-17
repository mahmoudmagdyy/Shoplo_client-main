import '../../../addresses/domain/entities/country.dart';

class StateEntity {
  StateEntity({
     required this.id,
     required this.name,
     required this.country,
     required this.isActive,
     required this.createdAt,
  });

  final int id;
  final String name;
  final Country country;
  final bool isActive;
  final String createdAt;

  factory StateEntity.fromJson(Map<String, dynamic> json) => StateEntity(
    id: json["id"]??0,
    name: json["name"]??"",
    country:Country.fromJson(json["country"]??{}),
    isActive: json["is_active"]??false,
    createdAt: json["created_at"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country.toJson(),
    "is_active": isActive,
    "created_at": createdAt,
  };
}