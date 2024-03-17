import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class ProductsDataProvider {
  Future<AppResponse> getStoresProducts(query) async {
    debugPrint('QUERY xxxx: $query}', wrapWidth: 1024);
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.storesProducts,
      query: query,
    ).then(
      (value) {
        debugPrint('VALUE storesProducts ${value.data['data'].toString()}');

        response = AppResponse.fromJson({'data': value.data});
        response.meta = response.data['meta'];
        response.data = response.data['data'];
      },
    ).catchError(
      (error) {
        debugPrint(
            'error storesProducts ================================ ${error.toString()}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getProductDetails(id) async {
    late final AppResponse response;
    await DioHelper.getData(url: '${NetworkConstants.storesProducts}/$id').then(
      (value) {
        debugPrint('VALUE getProductDetails details ${value.data.toString()}');

        response = AppResponse.fromJson(value.data);
        response.data = value.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error details================================ ${error.toString()}');

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
