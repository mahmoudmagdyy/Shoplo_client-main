import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class CartDataProvider {
  Future<AppResponse> getCart() async {
    late final AppResponse response;
    await DioHelper.getData(url: NetworkConstants.cart).then(
      (value) {
        // debugPrint('VALUE getCart: $value}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        debugPrint('RESPONSE getCart: $response', wrapWidth: 1024);
        response.subtotal = response.data['subtotal'];
        debugPrint('RESPONSE getCart 1: $response', wrapWidth: 1024);
        response.meta = response.data['cart']['meta'];
        response.data = response.data['cart']['data'];
      },
    ).catchError(
      (error) {
        debugPrint(
            'error Cart================================ ${error.toString()}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> addToCart(data) async {
    late final AppResponse response;

    await DioHelper.postFormData(url: NetworkConstants.cart, data: data).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.data = value.data;
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

  Future<AppResponse> updateItemInCart(data) async {
    late final AppResponse response;
    await DioHelper.putData(
      url: NetworkConstants.cart,
      data: data,
    ).then(
      (value) {
        debugPrint('VALUE: $value}', wrapWidth: 1024);

        response = AppResponse.fromJson(value.data);
      },
    ).catchError(
      (error) {
        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> deleteItemFromCart(id) async {
    late final AppResponse response;
    await DioHelper.deleteData(
      url: NetworkConstants.cart,
      data: {
        'id': id,
      },
    ).then(
      (value) {
        response = AppResponse.fromJson({"data": true});
        // response.data = value.data;
      },
    ).catchError(
      (error) {
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
