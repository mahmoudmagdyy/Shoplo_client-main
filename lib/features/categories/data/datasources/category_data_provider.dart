import 'package:flutter/cupertino.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class CategoriesDataProvider {
  Future<AppResponse> getCategories(query) async {
    debugPrint('QUERY xxxx: $query}', wrapWidth: 1024);
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.categories,
      query: query,
    ).then(
      (value) {
        // debugPrint('VALUE stores ${value.data['data'].toString()}');

        response = AppResponse.fromJson({'data': value.data});
        if (response.data is Map) {
          response.meta = response.data['meta'];
          response.data = response.data['data'];
        }
      },
    ).catchError(
      (error) {
        debugPrint('error Stores================================ ${error.toString()}');

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
