import 'dart:developer';

import 'package:shoplo_client/core/config/network_constants.dart';
import 'package:shoplo_client/core/core_model/app_response.dart';
import 'package:shoplo_client/core/helpers/dio_helper.dart';
import 'package:flutter/material.dart';

class ShipByGlobalDataProvider {
  Future<AppResponse> addShipping(
    Map<String, dynamic> values,
  ) async {
    late final AppResponse response;
    await DioHelper.postData(url: NetworkConstants.shippings, data: values).then(
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

  Future<AppResponse> getShipping(
    Map<String, dynamic> values,
  ) async {
    late final AppResponse response;
    await DioHelper.getData(url: NetworkConstants.shippings, query: values).then(
      (value) {
        response = AppResponse.fromJson({
          'data': value.data["data"],
        });
        response.meta = value.data['meta'];

        log(value.data['meta'].toString());
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

  Future<AppResponse> getShippingOrder(
    Map<String, dynamic> values,
  ) async {
    late final AppResponse response;
    await DioHelper.getData(url: "${NetworkConstants.shippings}/${values["id"]}").then(
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

  Future<AppResponse> changeShippingStatus(id, query) async {
    late final AppResponse response;
    await DioHelper.putData(
      url: '${NetworkConstants.shippings}/$id${NetworkConstants.changeShippingStatus}',
      data: query,
    ).then(
      (value) {
        debugPrint('VALUE: ${value.data}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        // response.data = value.data;
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

  Future<AppResponse> payment(id, query) async {
    late final AppResponse response;
    await DioHelper.postFormData(url: '${NetworkConstants.shippings}/$id${NetworkConstants.shippingPayment}', data: query, query: {
      "_method": "PUT",
    }).then(
      (value) {
        debugPrint('VALUE: ${value.data}', wrapWidth: 1024);
        response = AppResponse.fromJson({'data': value.data});
        // response.data = value.data;
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
