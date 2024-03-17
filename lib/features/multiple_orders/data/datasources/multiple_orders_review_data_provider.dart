import 'package:shoplo_client/core/config/network_constants.dart';
import 'package:shoplo_client/core/core_model/app_response.dart';
import 'package:shoplo_client/core/helpers/dio_helper.dart';
import 'package:flutter/material.dart';

class MultipleOrdersReviewDataProvider {
  Future<AppResponse> createOrder(query) async {
    late final AppResponse response;
    await DioHelper.postFormData(url: NetworkConstants.orders, data: query).then(
      (value) {
        response = AppResponse.fromJson({'data': value.data});
        debugPrint('RESPONSE : $response', wrapWidth: 1024);
      },
    ).catchError(
      (error) {
        debugPrint('error================================ ${error.toString()}');

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
