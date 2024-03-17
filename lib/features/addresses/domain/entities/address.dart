import 'package:equatable/equatable.dart';

import 'city.dart';

class AddressEntity extends Equatable {
  const AddressEntity({
    required this.id,
    required this.title,
    required this.phone,
    required this.isPrimary,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.nearestLandmarks,
    required this.city,
  });

  final int id;
  final String title;
  final String phone;
  final bool isPrimary;
  final String address;
  final String latitude;
  final String longitude;
  final String nearestLandmarks;
  final City city;

  @override
  List<Object> get props {
    return [
      id,
      title,
      phone,
      isPrimary,
      address,
      latitude,
      longitude,
      nearestLandmarks,
      city,
    ];
  }
}
