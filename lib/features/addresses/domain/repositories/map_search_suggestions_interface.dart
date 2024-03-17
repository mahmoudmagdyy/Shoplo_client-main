import '../../../../core/core_model/app_response.dart';

abstract class SearchMapSuggestionsInterface {
  Future<AppResponse> getSuggestions(
      String placeName, String sessionToken, String language);
  Future<AppResponse> getPlaceDetails(
      String placeId, String sessionToken, String language);
  Future<AppResponse> getReverseGeocoding(String latLng, String language);
}
