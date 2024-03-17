import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../core/config/map_config.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class SearchMapSuggestionsDataProvider {
  Future<AppResponse> getSearchMapSuggestions(
    String placeName,
    String sessionToken,
    String language, {
    String? country,
  }) async {
    log(country ?? 'country is null');
    late final AppResponse response;
    await DioHelper.getData(
      url: MapConfiguration.suggestionsBaseUrl,
      query: {
        'input': placeName,
        'types': 'address',
        if (country != null) 'components': 'country:$country',
        'key': MapConfiguration.apiKeyMaps,
        'sessiontoken': sessionToken,
        'language': language,
      },
    ).then(
      (value) {
        debugPrint(' getSearchMapSuggestions VALUE in get: ${value.data}',
            wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data['predictions']});
      },
    ).catchError(
      (error) {
        debugPrint('getSearchMapSuggestions ERROR: $error}', wrapWidth: 1024);
        debugPrint(
            'getSearchMapSuggestions ================================ ${error?.message}');
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getPlaceDetails(
    String placeId,
    String sessionToken,
    String language,
  ) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: MapConfiguration.placeDetailsBaseUrl,
      query: {
        'place_id': placeId,
        'fields': 'geometry,formatted_address',
        'key': MapConfiguration.apiKeyMaps,
        'sessiontoken': sessionToken,
        'language': language,
      },
    ).then(
      (value) {
        debugPrint(' getPlaceDetails VALUE in get: ${value.data}',
            wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data['result']});
      },
    ).catchError(
      (error) {
        debugPrint('getPlaceDetails ERROR: $error}', wrapWidth: 1024);
        debugPrint(
            'getPlaceDetails ================================ ${error?.message}');
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getReverseGeocoding(
    String latLng,
    String language,
  ) async {
    debugPrint('getReverseGeocoding latLng: $latLng}', wrapWidth: 1024);

    late final AppResponse response;
    await DioHelper.getData(
      url: MapConfiguration.reverseGeocodingBaseUrl,
      query: {
        'latlng': latLng,
        'key': MapConfiguration.apiKeyMaps,
        'language': language,
        "result_type":
            "political|administrative_area_level_1|administrative_area_level_2|administrative_area_level_3",
        // "result_type":"administrative_area_level_3",
        // "result_type":"political",
      },
    ).then(
      (value) {
        // debugPrint(
        //     ' getReverseGeocoding VALUE in get: ${value.data['results']}',
        //     wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data['results']});
      },
    ).catchError(
      (error) {
        debugPrint('getReverseGeocoding ERROR: $error}', wrapWidth: 1024);
        debugPrint(
            'getPlaceDetails ================================ ${error?.message}');
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }
}
