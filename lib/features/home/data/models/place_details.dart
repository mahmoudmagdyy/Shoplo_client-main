import 'package:equatable/equatable.dart';

class PlaceDetails extends Equatable {
  final String businessStatus;
  final double lat;
  final double lng;
  final String icon;
  final String name;
  final bool isOpen;
  final bool isGoogleStore;

  final List<String> photos;
  final String rating;
  final String userRatingsTotal;
  // final String scope;
  final String placeId;
  // final List<String> types;
  final String address;

  const PlaceDetails({
    required this.businessStatus,
    required this.lat,
    required this.lng,
    required this.icon,
    required this.name,
    required this.isOpen,
    required this.isGoogleStore,
    required this.photos,
    required this.rating,
    required this.userRatingsTotal,
    // required this.scope,
    required this.placeId,
    // required this.types,
    required this.address,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      businessStatus: json['business_status'] ?? '',
      lat: json['latitude'] != null
          ? double.parse(json['latitude'])
          : json['geometry']['location']['lat'],
      lng: json['latitude'] != null
          ? double.parse(json['longitude'])
          : json['geometry']['location']['lng'],
      icon: json['icon'] ?? json['avatar'],
      name: json['name'],
      isOpen: json['opening_hours'] != null
          ? json['opening_hours']['open_now']
          : true,
      isGoogleStore: json['isGoogleStore'] ?? false,
      photos: json['photos'] != null
          ? List.from(json['photos'])
              .map((e) => e['photo_reference'].toString())
              .toList()
          : json['image'] != null
              ? [json['image']]
              : [],
      rating: json['rating'] != null ? json['rating'].toString() : '0',
      userRatingsTotal: json['user_ratings_total'] != null
          ? json['user_ratings_total'].toString()
          : '0',
      // scope: json['scope'],
      placeId: json['place_id'] ?? json['id'].toString(),
      // types: List.from(json['types']).map((e) => e.toString()).toList(),
      address: json['vicinity'] ?? json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  @override
  List<Object> get props {
    return [
      businessStatus,
      lat,
      lng,
      icon,
      name,
      isOpen,
      photos,
      rating,
      userRatingsTotal,
      // scope,
      placeId,
      // types,
      address,
    ];
  }

  @override
  String toString() {
    return 'PlaceDetails(businessStatus: $businessStatus, lat: $lat, lng: $lng, icon: $icon, name: $name, isOpen: $isOpen, photos: $photos, rating: $rating, userRatingsTotal: $userRatingsTotal, placeId: $placeId, address: $address)';
  }
}
