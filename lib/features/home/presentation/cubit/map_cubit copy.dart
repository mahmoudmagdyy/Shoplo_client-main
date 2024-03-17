// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/datasources/search_map_data_provider.dart';
// import '../../data/datasources/stores_data_provider.dart';
// import '../../data/models/map_search_suggestion.dart';
// import '../../data/models/place_details.dart';
// import '../../data/models/store.dart';
// import '../../data/repositories/search_map_suggestions_repository.dart';
// import '../../data/repositories/stores_repository.dart';

// part 'map_state.dart';

// class MapCubit extends Cubit<MapState> {
//   MapCubit() : super(MapInitial());

//   static MapCubit get(context) => BlocProvider.of(context);
//   static final dataProvider = SearchMapSuggestionsDataProvider();
//   static final SearchMapSuggestionsRepository repository =
//       SearchMapSuggestionsRepository(dataProvider);
//   static final storesDataProvider = StoresDataProvider();
//   static final StoresRepository storesRepository =
//       StoresRepository(storesDataProvider);
//   List<SuggestionPlace> searchMapSuggestions = [];
//   List<PlaceDetails> googleStores = [];
//   List<StoreModel> stores = [];

//   void getGetSuggestion(
//       String placeName, String sessionToken, String language) {
//     emit(GetSuggestionLoadingState());
//     repository.getSuggestions(placeName, sessionToken, language).then(
//       (value) {
//         searchMapSuggestions = [];
//         if (value.errorMessages != null) {
//           emit(GetSuggestionErrorState(value.errorMessages!));
//         } else if (value.errors != null) {
//           emit(GetSuggestionErrorState(value.errors!));
//         } else {
//           value.data.forEach((item) {
//             searchMapSuggestions.add(SuggestionPlace.fromJson(item));
//           });
//           emit(GetSuggestionSuccessState(searchMapSuggestions));
//         }
//       },
//     );
//   }

//   void emptySearchMapSuggestions() {
//     searchMapSuggestions.clear();
//   }

//   void getGetPlaceDetails(
//       String placeId, String sessionToken, String language) {
//     emit(GetPlaceDetailsLoadingState());
//     repository.getPlaceDetails(placeId, sessionToken, language).then(
//       (value) {
//         if (value.errorMessages != null) {
//           emit(GetPlaceDetailsErrorState(value.errorMessages!));
//         } else if (value.errors != null) {
//           emit(GetPlaceDetailsErrorState(value.errors!));
//         } else {
//           emit(GetPlaceDetailsSuccessState(PlaceDetails.fromJson(value.data)));
//         }
//       },
//     );
//   }

//   void getReverseGeocoding(String latLng, String language) {
//     emit(GetReverseGeocodingLoadingState());
//     repository.getReverseGeocoding(latLng, language).then(
//       (value) {
//         debugPrint('VALUE: $value', wrapWidth: 1024);
//         if (value.errorMessages != null) {
//           emit(GetReverseGeocodingErrorState(value.errorMessages!));
//         } else if (value.errors != null) {
//           emit(GetReverseGeocodingErrorState(value.errors!));
//         } else {
//           if (value.data.length > 0) {
//             emit(GetReverseGeocodingSuccessState(
//                 PlaceDetails.fromJson(value.data[0])));
//           }
//         }
//       },
//     );
//   }

//   void getGoogleStores(
//       String latLng, String language, String radius, String pageToken) {
//     emit(GetGoogleStoresLoadingState());
//     repository.getGoogleStores(latLng, language, radius, pageToken).then(
//       (value) {
//         debugPrint('VALUE: $value', wrapWidth: 1024);
//         if (value.errorMessages != null) {
//           emit(GetGoogleStoresErrorState(value.errorMessages!));
//         } else if (value.errors != null) {
//           emit(GetGoogleStoresErrorState(value.errors!));
//         } else {
//           googleStores.clear();
//           List<PlaceDetails> places = [];
//           if (value.data.length > 0) {
//             value.data.forEach((item) {
//               places
//                   .add(PlaceDetails.fromJson({...item, 'isGoogleStore': true}));
//             });
//             googleStores.addAll(places);
//           }
//           emit(GetStoresLoadingState());
//           storesRepository.getStores({
//             'latitude': latLng.split(',')[0],
//             'longitude': latLng.split(',')[1],
//           }).then(
//             (response) {
//               if (response.errorMessages != null) {
//                 emit(GetStoresErrorState(response.errorMessages!));
//               } else if (response.errors != null) {
//                 emit(GetStoresErrorState(response.errors!));
//               } else {
//                 places.clear();
//                 response.data.forEach((item) {
//                   places.add(PlaceDetails.fromJson(item));
//                   debugPrint('PLACES: ${places.length}', wrapWidth: 1024);
//                 });
//                 googleStores.addAll(places);
//                 googleStores.shuffle();
//                 debugPrint(
//                     "🚀 getGoogleStores ~ file: map_cubit.dart ~ line 126 ~ MapCubit ~ ${googleStores.length}");
//                 emit(GetGoogleStoresSuccessState(googleStores));
//               }
//             },
//           );
//         }
//       },
//     );
//   }
// }
