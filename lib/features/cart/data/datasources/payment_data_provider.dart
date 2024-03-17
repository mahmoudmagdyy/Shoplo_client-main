import 'package:flutter/foundation.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class PaymentDataProvider {
  Future<AppResponse> getPaymentMethods() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.paymentMethods,
    ).then(
      (value) {
        debugPrint('VALUE Payment methods ${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        response.data = response.data;
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

  Future<AppResponse> checkCoupon(data) async {
    late final AppResponse response;
    await DioHelper.postData(url: NetworkConstants.checkCoupon, data: data)
        .then(
      (value) {
        debugPrint('VALUE checkCoupon${value.data.toString()}');
        response = AppResponse.fromJson(value.data);
        response.data = response.data;
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

  Future<AppResponse> getOnlineMethods() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.onlineMethods,
    ).then(
      (value) {
        debugPrint('VALUE onlineMethods ${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        response.data = response.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error onlineMethods================================ ${error.toString()}');

        if (error?.response != null) {
          response = AppResponse.withErrorResponse(error.response);
        } else {
          response = AppResponse.withErrorString(error.message);
        }
      },
    );
    return response;
  }

  Future<AppResponse> getBanks() async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.banks,
    ).then(
      (value) {
        debugPrint('VALUE getBanks ${value.data.toString()}');
        response = AppResponse.fromJson({'data': value.data});
        response.data = response.data;
      },
    ).catchError(
      (error) {
        debugPrint(
            'error getBanks================================ ${error.toString()}');

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
