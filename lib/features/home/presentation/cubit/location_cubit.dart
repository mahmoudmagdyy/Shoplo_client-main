import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);

  late LatLng latLng;
  bool _serviceEnabled = false;
  late LocationPermission _permissionGranted;

  late Position _currentPosition;

  void setLatLng(LatLng newLatLng) {
    latLng = newLatLng;
    emit(SetLatLngState());
  }

  Future getCurrentLocation() async {
    debugPrint(
        "🚀 ~ file: location_cubit.dart ~ line 19 ~ LocationCubit ~ getCurrentLocation");
    emit(GetCurrentLocationLoadingState());
    try {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint('_serviceEnabled $_serviceEnabled');
      if (!_serviceEnabled) {
        _serviceEnabled = await Geolocator.openLocationSettings();
        if (!_serviceEnabled) {
          emit(const ServiceEnabledErrorState('service not enabled'));
          return;
        }
      }

      _permissionGranted = await Geolocator.checkPermission();
      if (_permissionGranted == LocationPermission.denied ||
          _permissionGranted == LocationPermission.deniedForever) {
        _permissionGranted = await Geolocator.requestPermission();
        if (_permissionGranted == LocationPermission.denied ||
            _permissionGranted == LocationPermission.deniedForever) {
          emit(const ServiceEnabledErrorState('permission not granted'));
          return;
        }
      }
      _currentPosition = await Geolocator.getCurrentPosition();
      final newLatLng =
          LatLng(_currentPosition.latitude, _currentPosition.longitude);
      setLatLng(newLatLng);
      emit(GetCurrentLocationSuccessState(latLng));
    } on PlatformException catch (err) {
      debugPrint('_serviceEnabled error $err');
      emit(GetCurrentLocationErrorState(err.toString()));
    }
  }
}
