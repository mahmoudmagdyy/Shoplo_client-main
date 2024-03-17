part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class GetCurrentLocationLoadingState extends LocationState {}

class SetLatLngState extends LocationState {}

class GetCurrentLocationSuccessState extends LocationState {
  final LatLng latLng;
  const GetCurrentLocationSuccessState(this.latLng);
}

class GetCurrentLocationErrorState extends LocationState {
  final String error;
  const GetCurrentLocationErrorState(this.error);
}

class ServiceEnabledErrorState extends LocationState {
  final String error;
  const ServiceEnabledErrorState(this.error);
}

class PermissionGrantedErrorState extends LocationState {
  final String error;
  const PermissionGrantedErrorState(this.error);
}
