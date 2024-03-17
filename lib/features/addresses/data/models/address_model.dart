import 'package:shoplo_client/features/addresses/domain/entities/address.dart';
import '../../domain/entities/city.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.title,
    required super.phone,
    required super.isPrimary,
    required super.address,
    required super.latitude,
    required super.longitude,
    required super.nearestLandmarks,
    required super.city,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        title: json["title"],
        phone: json["phone"],
        isPrimary: json["is_primary"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        nearestLandmarks: json["nearest_landmarks"] ?? "",
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "phone": phone,
        "is_primary": isPrimary,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "nearest_landmarks": nearestLandmarks,
        "city": city.toJson(),
      };
}
