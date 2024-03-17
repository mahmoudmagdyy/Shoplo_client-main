part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class GetSuggestionLoadingState extends MapState {}

class GetSuggestionSuccessState extends MapState {
  final List<SuggestionPlace> places;
  const GetSuggestionSuccessState(this.places);
}

class GetSuggestionErrorState extends MapState {
  final String error;
  const GetSuggestionErrorState(this.error);
}

class GetPlaceDetailsLoadingState extends MapState {}

class GetPlaceDetailsSuccessState extends MapState {
  final PlaceDetails placeDetails;
  const GetPlaceDetailsSuccessState(this.placeDetails);
}

class GetPlaceDetailsErrorState extends MapState {
  final String error;
  const GetPlaceDetailsErrorState(this.error);
}

class GetReverseGeocodingLoadingState extends MapState {}

class GetReverseGeocodingSuccessState extends MapState {
  final PlaceDetails placeDetails;
  const GetReverseGeocodingSuccessState(this.placeDetails);
}

class GetReverseGeocodingErrorState extends MapState {
  final String error;
  const GetReverseGeocodingErrorState(this.error);
}
