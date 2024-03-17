import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class CitiesDataProvider {
  Future<AppResponse> getCities(String countryId) async {
    late final AppResponse response;
    await DioHelper.getData(url: '${NetworkConstants.countries}/$countryId')
        .then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
      },
    ).catchError(
      (error) {
        debugPrint('error ================================ ${error?.message}');
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
