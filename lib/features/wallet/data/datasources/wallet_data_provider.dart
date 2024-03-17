import 'package:flutter/material.dart';

import '../../../../core/config/network_constants.dart';
import '../../../../core/core_model/app_response.dart';
import '../../../../core/helpers/dio_helper.dart';

class WalletDataProvider {
  Future<AppResponse> getWalletTransactions(query) async {
    late final AppResponse response;
    await DioHelper.getData(
      url: NetworkConstants.userTransactions,
      query: query,
    ).then(
      (value) {
        response = AppResponse.fromJson(value.data);
        response.total = value.data['total'];
        response.meta = value.data['transactions']['meta'];
        response.data = value.data['transactions']['data'];
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

  Future<AppResponse> makeBankTransfer(values) async {
    late final AppResponse response;

    await DioHelper.postData(
      url: NetworkConstants.banksTransfer,
      data: values, 
    ).then(
      (value) {
        debugPrint('value makeBankTransfer ================================ ${value.toString()}');
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
}
