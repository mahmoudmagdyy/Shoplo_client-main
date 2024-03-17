import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/search_map_data_provider.dart';
import '../../data/datasources/stores_data_provider.dart';
import '../../data/models/map_search_suggestion.dart';
import '../../data/models/place_details.dart';
import '../../data/repositories/search_map_suggestions_repository.dart';
import '../../data/repositories/stores_repository.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);
  static final dataProvider = SearchMapSuggestionsDataProvider();
  static final SearchMapSuggestionsRepository repository =
      SearchMapSuggestionsRepository(dataProvider);
  static final storesDataProvider = StoresDataProvider();
  static final StoresRepository storesRepository =
      StoresRepository(storesDataProvider);
  List<SuggestionPlace> searchMapSuggestions = [];
  bool refresh = false;
  void getGetSuggestion(
      String placeName, String sessionToken, String language) {
    emit(GetSuggestionLoadingState());
    repository.getSuggestions(placeName, sessionToken, language).then(
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
          emit(GetReverseGeocodingErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetReverseGeocodingErrorState(value.errors!));
        } else {
          if (value.data.length > 0) {
            emit(GetReverseGeocodingSuccessState(
                PlaceDetails.fromJson(value.data[0])));
          }
        }
      },
    );
  }

  final List<PlaceDetails> googleStores = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  bool loadingMoreResults = false;
  Map<String, dynamic> query = {'page': 1, 'per_page': 10, 'pageToken': ''};

  void clearGoogleStores() {
    googleStores.clear();
    emit(ClearStoresState());
  }

  void getGoogleStores(queryData) {
    if (query['type'] != queryData['type']) {
      googleStores.clear();
    }
    debugPrint('QUERY DATA getGoogleStores: $queryData}', wrapWidth: 1024);
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      googleStores.clear();
      query.clear();
      query['page'] = 1;
      query['per_page'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      googleStores.clear();
      emit(GetGoogleStoresLoadingState());
    } else {
      loadingMoreResults = true;
      emit(GetGoogleStoresLoadingNextPageState());
    }
    debugPrint('QUERY DATA getGoogleStores query: $query}', wrapWidth: 1024);

    repository.getGoogleStores(query).then(
      (value) {
        debugPrint('VALUE: $value', wrapWidth: 1024);
        loadingMoreResults = false;

        if (value.errorMessages != null) {
          emit(GetGoogleStoresErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(GetGoogleStoresErrorState(value.errors!));
        } else {
          endLoadingFirstTime = true;
          List<PlaceDetails> places = [];
          if (value.data.length > 0) {
            value.data.forEach((item) {
              places
                  .add(PlaceDetails.fromJson({...item, 'isGoogleStore': true}));
            });
          }

          debugPrint('places length ${places.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            googleStores.addAll(places);
          } else {
            googleStores.clear();
            googleStores.addAll(places);
          }
          if (value.pageToken == null) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (value.pageToken != null) {
            query['pagetoken'] = value.pageToken;
            query['page'] += 1;
            hasReachedEndOfResults = false;
          }
          debugPrint('orders ${googleStores.length}');
          // if (query['page'] < value.meta['last_page']) {
          //   debugPrint('load more 2222 page ++ ');
          //   query['page'] += 1;
          //   query['pageToken'] = value.pageToken;
          // } else {
          //   query['page'] = 1;
          // }

          emit(GetGoogleStoresSuccessState(googleStores));
        }
      },
    );
  }
}
