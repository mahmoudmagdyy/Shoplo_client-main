import '../../../../core/core_model/app_response.dart';
import '../../domain/repositories/map_search_suggestions_interface.dart';
import '../data_source/search_map_data_provider.dart';

class SearchMapSuggestionsRepository implements SearchMapSuggestionsInterface {
  final SearchMapSuggestionsDataProvider searchMapSuggestionsDataProvider;
  const SearchMapSuggestionsRepository(this.searchMapSuggestionsDataProvider);

  @override
  Future<AppResponse> getSuggestions(
      String placeName, String sessionToken, String language,
      {String? country}) {
    return searchMapSuggestionsDataProvider.getSearchMapSuggestions(
        placeName, sessionToken, language,
        country: country);
  }

  @override
  Future<AppResponse> getPlaceDetails(
      String placeId, String sessionToken, String language) {
    return searchMapSuggestionsDataProvider.getPlaceDetails(
        placeId, sessionToken, language);
  }

  @override
  Future<AppResponse> getReverseGeocoding(String latLng, String language) {
    return searchMapSuggestionsDataProvider.getReverseGeocoding(
        latLng, language);
  }
}
