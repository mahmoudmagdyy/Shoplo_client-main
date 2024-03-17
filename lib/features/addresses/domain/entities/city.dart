import 'package:shoplo_client/features/addresses/domain/entities/state.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.state,
    required this.isActive,
    required this.createdAt,
    required this.longitude,
    required this.latitude,
  });

  final int id;
  final String name;
  final StateEntity state;
  final bool isActive;
  final String createdAt;
  final String longitude;
  final String latitude;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        state: StateEntity.fromJson(json["state"] ?? {}),
        isActive: json["is_active"] ?? false,
        createdAt: json["created_at"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state.toJson(),
        "is_active": isActive,
        "created_at": createdAt,
      };
}
