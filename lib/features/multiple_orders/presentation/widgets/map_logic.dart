import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplo_client/features/home/data/models/place_details.dart';

import '../../../../resources/images/images.dart';

mixin MapLogicMixin {
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = <Marker>{};
  late BitmapDescriptor marker1;
  late BitmapDescriptor marker2;
  late LatLng latLng;
  void addMarkers(List<PlaceDetails> stores,
      {Function(PlaceDetails)? onTapMarker}) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(latLng.latitude, latLng.longitude),
        icon: marker1,
      ),
    );

    for (var element in stores) {
      markers.add(
        Marker(
          markerId: MarkerId(element.placeId.toString()),
          position: LatLng(element.lat, element.lng),
          icon: marker2,
          onTap: () {
            onTapMarker?.call(element);
          },
          infoWindow: InfoWindow(
            title: element.name,
            snippet: element.address,
          ),
        ),
      );
    }
  }

  Future<void> setMapIcons() async {
    if (Platform.isIOS) {
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)), AppImages.iconMap1)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker1 = icon;
      });
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)), AppImages.iconMap2)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker2 = icon;
      });
    } else {
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)), AppImages.marker1)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker1 = icon;
      });
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)), AppImages.marker2)
          .then((icon) {
        debugPrint('finish icon ===== ');
        marker2 = icon;
      });
    }
  }

  //setLocation
  setLocation(LatLng latLng) {
    this.latLng = latLng;
    _goToMyCurrentLocation(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 14,
    ));
  }

  Future<void> _goToMyCurrentLocation(myLocation) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myLocation));
  }
}
