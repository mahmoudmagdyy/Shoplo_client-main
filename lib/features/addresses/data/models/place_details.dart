import 'package:equatable/equatable.dart';

class PlaceDetails extends Equatable {
  final double lat;
  final double lng;
  final String address;

  const PlaceDetails({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
      address: json['formatted_address'],
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };

  @override
  String toString() => 'lat: $lat lng: $lng';

  @override
  List<Object?> get props => [lat, lng];
}