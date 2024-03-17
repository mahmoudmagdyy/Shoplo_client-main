import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_source/search_map_data_provider.dart';
import '../../../data/models/map_search_suggestion.dart';
import '../../../data/models/place_details.dart';
import '../../../data/repositories/search_map_suggestions_repository.dart';

part 'map_state.dart';

class MapAddressCubit extends Cubit<MapState> {
  MapAddressCubit() : super(MapInitial());

  static MapAddressCubit get(context) => BlocProvider.of(context);
  static final dataProvider = SearchMapSuggestionsDataProvider();
  static final SearchMapSuggestionsRepository repository =
      SearchMapSuggestionsRepository(dataProvider);
  List<SuggestionPlace> searchMapSuggestions = [];

  void getGetSuggestion(String placeName, String sessionToken, String language,
      {String? country}) {
    log(country.toString());
    emit(GetSuggestionLoadingState());
    repository
        .getSuggestions(placeName, sessionToken, language, country: country)
        .then(
      (value) {
        searchMapSuggestions = [];
        if (value.errorMessages != null) {
          emit(GetSuggestionErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetSuggestionErrorState(value.errors!));
        } else {
          value.data.forEach((item) {
            searchMapSuggestions.add(SuggestionPlace.fromJson(item));
          });
          emit(GetSuggestionSuccessState(searchMapSuggestions));
        }
      },
    );
  }

  void emptySearchMapSuggestions() {
    searchMapSuggestions.clear();
  }

  void getGetPlaceDetails(
      String placeId, String sessionToken, String language) {
    emit(GetPlaceDetailsLoadingState());
    repository.getPlaceDetails(placeId, sessionToken, language).then(
      (value) {
        if (value.errorMessages != null) {
          emit(GetPlaceDetailsErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetPlaceDetailsErrorState(value.errors!));
        } else {
          emit(GetPlaceDetailsSuccessState(PlaceDetails.fromJson(value.data)));
        }
      },
    );
  }

  void getReverseGeocoding(String latLng, String language) {
    emit(GetReverseGeocodingLoadingState());
    repository.getReverseGeocoding(latLng, language).then(
      (value) {
        debugPrint('VALUE: $value', wrapWidth: 1024);
        if (value.errorMessages != null) {
          print('sdasdasd');
          emit(GetReverseGeocodingErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          print('sdasdasd');
          emit(GetReverseGeocodingErrorState(value.errors!));
        } else {
          if (value.data.length > 0) {
            print('sdasdasd');
            // print('fgdfgfdgdfgdfgf' + value.data[0]);
            emit(GetReverseGeocodingSuccessState(
                PlaceDetails.fromJson(value.data[0])));
          }
        }
      },
    );
  }
}
